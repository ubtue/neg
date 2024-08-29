<?php

/**
 * This script is used to generate a sql patch
 * out of the xlsx (csv) file that Dieter Geuenich sent in june 2024.
 */

$csvPath = 'duplicate_lemma_einzelbeleg-Korr. in Spalte E.csv';
$sqlPath = 'duplicate_lemma_einzelbeleg-Korr. in Spalte E.sql';

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
// into grouped array (by lemma text) with named columns
function groupCsvData(array $rows) : array {
    $data = [];
    foreach ($rows as $row) {
        $dataset = [
            'einzelbelegId' => $row[0],
            'einzelbelegBelegform' => $row[1],
            'mghLemmaId' => $row[2],
            'mghLemmaText' => $row[3],
            'mghLemmaTargetGroup' => $row[4],
        ];
        $groupKeyField = 'mghLemmaText';
        $groupKey = $dataset[$groupKeyField];
        if (!isset($data[$groupKey])) {
            $data[$groupKey] = [];
        }
        $data[$groupKey][] = $dataset;
    }
    return $data;
}

// Generate map of source lemma id => target lemma id
function mapMghLemmaIds(array $data): array {
    $map = [];
    foreach ($data as $groupKey => $datasets) {
        foreach ($datasets as $dataset) {
            if (!empty($dataset['mghLemmaTargetGroup'])) {
                $sourceMghLemmaId = $dataset['mghLemmaId'];
                $targetMghLemmaId = $data[$dataset['mghLemmaTargetGroup']][0]['mghLemmaId'] ?? null;
                if (!empty($sourceMghLemmaId) && !empty($targetMghLemmaId) && $sourceMghLemmaId != $targetMghLemmaId) {
                    $map[$sourceMghLemmaId] = $targetMghLemmaId;
                }
            }
        }
    }
    return $map;
}

// Generate SQL Statements out of map with source lemma id => target lemma id
function generateSqlStatements(array $map) : string {
    $sql = 'BEGIN;' . PHP_EOL;
    foreach ($map as $sourceId => $targetId) {
        $sql .= 'UPDATE einzelbeleg_hatmghlemma SET MGHLemmaID=' . $targetId . ' WHERE MGHLemmaID=' . $sourceId . ';' . PHP_EOL;
        $sql .= 'DELETE FROM mgh_lemma_bearbeiter WHERE MGHLemmaID=' . $sourceId . ';' . PHP_EOL;
        $sql .= 'DELETE FROM mgh_lemma_korrektor WHERE MGHLemmaID=' . $sourceId . ';' . PHP_EOL;
        $sql .= 'DELETE FROM mgh_lemma WHERE ID=' . $sourceId . ';' . PHP_EOL;
    }
    $sql .= 'COMMIT;' . PHP_EOL;
    return $sql;
}

$rows = parseCsv($csvPath);
$data = groupCsvData($rows);
$map = mapMghLemmaIds($data);
$sql = generateSqlStatements($map);
file_put_contents($sqlPath, $sql);
