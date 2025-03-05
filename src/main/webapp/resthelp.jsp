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
            <td>Fetches a single item by its identifier. The ID can start with <code>M</code>, <code>N</code>, or <code>B</code>.</td>
            <td><code>/rest/item/B1319</code></td>
        </tr>
        <tr>
            <td><code>/rest/items/{id1},{id2},{id3}</code></td>
            <td>GET</td>
            <td>Fetches multiple items by their identifiers.</td>
            <td><code>/rest/items/B1319,B1320,B1321</code></td>
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
    <p>URL: <code>/rest/item/N2</code></p>
    <pre>
Response:
{
  "bearbeitungsstatus": "completed",
  "dateiname": "86",
  "letzteAenderung": "2023-04-25 11:42:10.0",
  "protokoll": "Test",
  "PLemma": "id~win.i-z",
  "id": "N2",
  "ELemma": "id"
}
    </pre>

    <h3>Fetch Multiple Items</h3>
    <p>URL: <code>/rest/items/N2,N7,N8</code></p>
    <pre>
Response:
{
    "items": [
      {
        "bearbeitungsstatus": "completed",
        "dateiname": "86",
        "letzteAenderung": "2023-04-25 11:42:10.0",
        "protokoll": "Test",
        "PLemma": "id~win.i-z",
        "id": "N2",
        "ELemma": "id"
      },
      {
        "bearbeitungsstatus": "-",
        "dateiname": "138",
        "letzteAenderung": "2023-04-25 10:16:48.0",
        "PLemma": "leud.i~ha@!d.u-z",
        "id": "N7"
      },
      {
        "bearbeitungsstatus": "-",
        "dateiname": "28",
        "letzteAenderung": "2023-04-25 11:42:13.0",
        "protokoll": "Abfragen: %Land%ol%: +; %Lant%ol%: +; %Land%al%: -; %Lant%al%: +; %Lam%l%: -; %Lan%l%: nichts über die obige Abfrage hinaus",
        "PLemma": "land.a~bal@!d.a-z",
        "id": "N8"
      }
    ]
}
    </pre>

    <h2>Notes</h2>
    <ul>
        <li>Identifiers must follow the format <code>M{number}</code>, <code>N{number}</code>, or <code>B{number}</code>.</li>
        <li>All responses are in JSON format with proper UTF-8 encoding.</li>
    </ul>
</body>
</html>
