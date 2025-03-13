<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>REST API Documentation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            line-height: 1.6;
        }
        h1 {
            color: #333;
        }
        code {
            background-color: #f4f4f4;
            padding: 4px 6px;
            border-radius: 4px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        th {
            background-color: #f9f9f9;
            text-align: left;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>REST API Documentation</h1>
    <p>Welcome to the REST API for the NPPM project. Below is an overview of the available endpoints and their usage.</p>

    <h2>Endpoints</h2>
    <table>
        <thead>
        <tr>
            <th>Endpoint</th>
            <th>Method</th>
            <th>Description</th>
            <th>Example</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td><code>/rest/item/{id}</code></td>
            <td>GET</td>
            <td>Fetches a single item by its identifier. The ID can start with <code>Q</code>,<code>M</code>, <code>P</code>, or <code>B</code>.</td>
            <td><code>/rest/item/B1319</code></td>
        </tr>
        <tr>
            <td><code>/rest/items/{id1},{id2},{id3}</code></td>
            <td>GET</td>
            <td>Fetches multiple items by their identifiers.</td>
            <td><code>/rest/items/B1319,B1320,B1321</code></td>
        </tr>
        <tr>
            <td><code>/rest/lemma/{belegform}</code></td>
            <td>GET</td>
            <td>Fetches the lemma corresponding to the given Belegform.</td>
            <td><code>/rest/lemma/Sebastianus</code></td>
        </tr>
        <tr>
            <td><code>/rest/lemmas/{belegform1},{belegform2}</code></td>
            <td>GET</td>
            <td>Fetches multiple lemmas for the given Belegformen.</td>
            <td><code>/rest/lemmas/Sebastianus,Libinonem</code></td>
        </tr>
        <tr>
            <td><code>/rest</code></td>
            <td>GET</td>
            <td>Displays this help page with information about the API.</td>
            <td><code>/rest</code></td>
        </tr>
        </tbody>
    </table>

    <h2>Examples</h2>
    <h3>Fetch a Single Item</h3>
    <p>URL: <code>/rest/item/M6360</code></p>
    <pre>
Response:
{
  "mghLemma": "sebastiānus",
  "letzteAenderungVon": "Team",
  "letzteAenderung": "06.08.2024 11:54:26",
  "id": "M6360"
}
    </pre>

    <h3>Fetch Multiple Items</h3>
    <p>URL: <code>/rest/items/M6360,M6361,M6362</code></p>
    <pre>
Response:
{
"items": [
  {
    "mghLemma": "sebastiānus",
    "letzteAenderungVon": "Team",
    "letzteAenderung": "06.08.2024 11:54:26",
    "id": "M6360"
  },
  {
    "mghLemma": "leub-n",
    "id": "M6361"
  },
  {
    "mghLemma": "latīnus",
    "id": "M6362"
  }
]
}
    </pre>
        <h3>Fetch a Lemma by Belegform</h3>
    <p>URL: <code>/rest/lemma/Sebastianus</code></p>
    <pre>
Response:
{
  "ID": "M6360",
  "Lemma": "Sebastianus"
}
    </pre>

    <h3>Fetch Multiple Lemmas by Belegformen</h3>
    <p>URL: <code>/rest/lemmas/Sebastianus,Libinonem</code></p>
    <pre>
Response:
{
    "items": [
      {
        "ID": "M6360",
        "Lemma": "Sebastianus"
      },
      {
        "ID": "M7420",
        "Lemma": "Libinonem"
      }
    ]
}
    </pre>

    <h2>Notes</h2>
    <ul>
        <li>Identifiers must follow the format <code>Q{number}</code>,<code>M{number}</code>, <code>P{number}</code>, or <code>B{number}</code>.</li>
        <li>All responses are in JSON format with proper UTF-8 encoding.</li>
    </ul>
</body>
</html>
