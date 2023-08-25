<%@page import="com.google.gson.Gson"%>
<%@page import="de.uni_tuebingen.ub.nppm.db.*"%>
﻿<%@ page import="java.math.BigInteger" isThreadSafe="false" %>
<%@ page import="java.util.*" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.util.AuthHelper" isThreadSafe="false" %>
<%@ page import="de.uni_tuebingen.ub.nppm.db.DatenbankDB" isThreadSafe="false" %>
<%@ include file="configuration.jsp" %>

<div>
    <jsp:include page="layout/navigation.inc.jsp" />
    <jsp:include page="layout/image.inc.html" />
    <jsp:include page="layout/titel.administration.jsp" />
    <div id="form">

        <h1>Baumstruktur bearbeiten</h1>
        <h2>Tabelle: ${param.Tabelle}</h2>
        <p>Bitte verwenden Sie Drag und Drop</p>

        <!-- Buttons to Expand and Collapse Tree -->
        <button id="collapseAllButton">Alles zuklappen</button>
        <button id="expandAllButton">Alles aufklappen</button>

        <br><br>

        <div id="data">
            <!-- The jsTree is created here -->
        </div>
    </div>

    <script>
        $(document).ready(function () {
            // Get source data from database
            let myQuelle = <%= new Gson().toJson(SelektionDB.getList(request.getParameter("Tabelle")))%>;

            // Create jsTree structure from the source data
            let treeData = [];
            for (let i = 0; i < myQuelle.length; i++) {
                let quelle = myQuelle[i];
                let node = {
                    id: quelle.id,
                    text: quelle.bezeichnung,
                    parent: (quelle.parentId !== null && quelle.parentId !== undefined) ? quelle.parentId : "#"
                };
                treeData.push(node);
            }

            // Initialize jstree component with dynamic data source
            $("#data").jstree({
                "core": {
                    "data": treeData,
                    "check_callback": true // Allow moving nodes
                },
                "plugins": ["dnd"]
            });

            // Button to expand the tree
            $("#expandAllButton").on("click", function () {
                $("#data").jstree("open_all");
            });

            // Button to collapse the tree
            $("#collapseAllButton").on("click", function () {
                $("#data").jstree("close_all");
            });

            $("#data").on("move_node.jstree", function (e, data) {
                let nodeId = data.node.id;
                let newParentId = data.parent;

                // Check if newParentId is undefined, null or empty and set it to Null
                if (typeof newParentId === "undefined" || newParentId === undefined || newParentId === null || newParentId === "" || newParentId === "#") {
                    newParentId = null;
                }

                // Send the data to the servlet via AJAX
                $.ajax({
                    url: "admin-baumstruktur", //  URL path to the servlet
                    method: "POST",
                    data: {
                        id: nodeId,
                        parentId: newParentId,
                        table: '${param.Tabelle}'
                    },
                    success: function (response) {
                        console.log("Parent ID updated successfully:", response);
                        console.log("New Parent ID from server:", response.newParentId);
                    },
                    error: function (error) {

                        console.error("Error updating Parent ID:", error);
                        console.log("Failed newParentId:", newParentId);
                    }
                });
            });
        });
    </script>
</div>
</div>