<?php

/**
 * This script is used to generate a sql patch
 * out of the xlsx (csv) file that Steffen Patzold sent in august 2024.
 */

$csvPath = 'Selektion_Funktion.csv';
$sqlPath = 'Selektion_Funktion.sql';

// Parse CSV file & generate simple numeric array
function parseCsv(string $csvPath) : array {
    $rows = [];
    $handle = fopen($csvPath, 'r');
    while (($row = fgetcsv($handle, 1000, ';', '"')) !== false) {
        $rows[] = $row;
    }
    fclose($handle);
    return $rows;
}

// Convert array with numeric columns
// into assoc array with named columns
function transformCsvData(array $rows) : array {
    $data = [];
    foreach ($rows as $row) {
        $remove = ($row[3] == 'True' ? true : false);
        $funktionNew = [];
        foreach ($row as $rownr => $column) {
            if ($rownr >= 4 && trim($column) != '')
                $funktionNew[] = trim($column);
        }

        // Sanity check
        if ($remove && !empty($funktionNew) || !$remove && empty($funktionNew)) {
            die('Sanity check failed: ' . print_r($row));
        }

        $dataset = [
            'selektionFunktionId' => trim($row[1]),
            'selektionFunktionBezeichnung' => trim($row[2]),
            'remove' => $remove,
            'selektionFunktionBezeichnungNeu' => $funktionNew,
        ];

        $data[] = $dataset;
    }
    return $data;
}

function getTargetEntries($data) {
    $newEntries = [];
    foreach ($data as $dataset) {
        $newEntries = array_merge($newEntries, $dataset['selektionFunktionBezeichnungNeu']);
        $newEntries = array_unique($newEntries);
    }
    return $newEntries;
}

function generateSqlStatements(array $data) {
    $sql = 'BEGIN;' . PHP_EOL . PHP_EOL;

    // Make sure all target entries exist
    $newEntries = getTargetEntries($data);
    foreach ($newEntries as $newEntry) {
        $sql .= 'INSERT IGNORE INTO selektion_funktion (ID, Bezeichnung) SELECT MAX(ID)+1, "' . $newEntry . '" FROM selektion_funktion;' . PHP_EOL;
    }
    $sql .= PHP_EOL;

    // Process datasets
    foreach ($data as $dataset) {
        if (in_array($dataset['selektionFunktionBezeichnung'], $newEntries))
            continue;

        if ($dataset['remove']) {
            $sql .= 'DELETE FROM einzelbeleg_hatfunktion WHERE FunktionID = ' . $dataset['selektionFunktionId'] . ';' . PHP_EOL;
        } else {
            foreach ($dataset['selektionFunktionBezeichnungNeu'] as $funktionNr => $funktionNew) {
                $subselectExistingFunktionId = 'SELECT ID FROM selektion_funktion WHERE Bezeichnung = "' . $funktionNew . '"';
                if ($funktionNr == 0) {
                    $sql .= 'UPDATE einzelbeleg_hatfunktion SET FunktionID = (' . $subselectExistingFunktionId . ') WHERE FunktionID = ' . $dataset['selektionFunktionId'] . ';' . PHP_EOL;
                } else {
                    $subselectForInsert = 'SELECT EinzelbelegID, (' . $subselectExistingFunktionId . ') FROM einzelbeleg_hatfunktion WHERE FunktionID = (' . $subselectExistingFunktionId . ');' . PHP_EOL;
                    $sql .= 'INSERT INTO einzelbeleg_hatfunktion (EinzelbelegID, FunktionID) ' . $subselectForInsert . PHP_EOL;
                }
            }

        }
        $sql .= 'DELETE FROM selektion_funktion WHERE ID = ' . $dataset['selektionFunktionId'] . ';' . PHP_EOL . PHP_EOL;
    }
    $sql .= 'COMMIT;' . PHP_EOL;
    return $sql;
}

$rows = parseCsv($csvPath);
$data = transformCsvData($rows);
$sql = generateSqlStatements($data);
file_put_contents($sqlPath, $sql);
