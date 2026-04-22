package de.uni_tuebingen.ub.nppm.cli;

import de.uni_tuebingen.ub.nppm.db.*;
import org.jgrapht.graph.DefaultDirectedGraph;
import org.jgrapht.graph.DefaultEdge;
import org.jgrapht.nio.*;
import org.jgrapht.nio.csv.*;
import org.jgrapht.nio.dot.*;
import org.jgrapht.nio.gexf.*;
import java.io.FileWriter;
import java.io.Writer;
import java.nio.file.Path;
import java.util.LinkedHashMap;
import java.util.Map;


public class Graph extends AbstractBase {
    // CLI Arguments
    private static Path outputPath;

    /**
     * Generate Graph-related data, e.g. for Gephi or Graphviz
     */
    public static void main (String[] args) throws Exception {
        // Load Properties (DB access credentials, etc.)
        LoadProperties();

        // Process args
        switch (args.length) {
            case 1:
                outputPath = Path.of(args[0]);
                break;
            default:
                Usage("Usage: Graph <outputPath(.csv|.dot|.gexf)> ");
        }

        export();

        // Exit successfully (we need this or the program will hang forever)
        System.exit(0);
    }

    private static void export() throws Exception {
        Log("Baue Graph...");
        org.jgrapht.Graph<String, DefaultEdge> graph =
                new DefaultDirectedGraph<>(DefaultEdge.class);

        // Note: We need to execute multi-pass, else vertices will not be found when creating edges
        // first: create all nodes (vertices)
        Log("Ermittle Knoten...");
        for (var person : PersonDB.getListPersonPublic()) {
            graph.addVertex(person.getPersistentIdentifier());
        }

        // - second: create all edges
        Log("Ermittle Kanten...");
        for (var person : PersonDB.getListPersonPublic()) {
            for (var beleg : person.getEinzelbeleg()) {
                // Keep it simple: Only relate personen within same einzelbeleg
                if (beleg.getQuelle().getZuVeroeffentlichen().equals(1)) {
                    for (var person2 : beleg.getPerson()) {
                        if (!person.getPersistentIdentifier().equals(person2.getPersistentIdentifier())) {

                            // quick & dirty workaround
                            if (!graph.containsVertex(person2.getPersistentIdentifier())) {
                                graph.addVertex(person2.getPersistentIdentifier());
                            }

                            graph.addEdge(person.getPersistentIdentifier(), person2.getPersistentIdentifier());
                        }
                    }
                }
            }
        }

        if (outputPath.toString().endsWith(".csv")) {
            Log("Exportiere als CSV");

            // ADJACENCY_LIST for Gephi
            CSVExporter<String, DefaultEdge> exporter =
            new CSVExporter<>(CSVFormat.ADJACENCY_LIST);

            // Vertex ID (important für CSV)
            exporter.setVertexIdProvider(v -> v);

            // Optional: Edge Label
            exporter.setEdgeIdProvider(e -> e.toString());

            try (Writer writer = new FileWriter(outputPath.toString())) {
                exporter.exportGraph(graph, writer);
            }
        } else if (outputPath.toString().endsWith(".dot")) {
            Log("Exportiere als DOT");
            DOTExporter<String, DefaultEdge> exporter = new DOTExporter<>();
            exporter.setVertexAttributeProvider((v) -> {
                Map<String, Attribute> map = new LinkedHashMap<>();
                map.put("label", DefaultAttribute.createAttribute(v));
                return map;
            });
            try (Writer writer = new FileWriter(outputPath.toString())) {
                exporter.exportGraph(graph, writer);
            }
        } else if (outputPath.toString().endsWith(".gexf")) {
            Log("Exportiere als GEXF");
            GEXFExporter<String, DefaultEdge> exporter = new GEXFExporter<>();
            try (Writer writer = new FileWriter(outputPath.toString())) {
                exporter.exportGraph(graph, writer);
            }
        } else {
            Log("Export fehlgeschlagen, unbekanntes Zielformat (unterstützt wird .csv|.dot|.gexf): " + outputPath);
            return;
        }

        Log("Export fertig: " + outputPath);
    }

}
