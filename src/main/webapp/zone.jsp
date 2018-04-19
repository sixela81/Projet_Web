
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/x-icon" href="images/admin.ico">
        <title>CA par zone géographique</title>
        <script	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <!-- On charge le moteur de template mustache https://mustache.github.io/ -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/mustache.js/0.8.1/mustache.min.js"></script>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <link rel="stylesheet" type="text/css" href="css/pageAdmin.css">
        <script>
            $(document).ready(// Exécuté à la fin du chargement de la page
                    function () {
                        showCAzone();
                        showCAzip();
                    }
            );

            google.charts.load('current', {'packages': ['corechart']});

            google.charts.setOnLoadCallback(showCAzone);

            function showCAzone() {
                $.ajax({
                    url: "CAzoneServlet",
                    data: $("#dates").serialize(),
                    dataType: "json",
                    success:
                            function (result) {
                                console.log(result);

                                var chartData = [];
                                // On met le descriptif des données
                                chartData.push(["Etat", "Ventes"]);
                                for (var state in result.records) {
                                    chartData.push([state, result.records[state]]);
                                }
                                //camembert ------------------------------------------------------------------------
                                var data = google.visualization.arrayToDataTable(chartData);

                                var options = {
                                    title: "Chiffre d'affaire par états"
                                };
                                var chart = new google.visualization.PieChart(document.getElementById('piechart'));

                                chart.draw(data, options);
                            },

                    error: showError

                });
            }

            google.charts.setOnLoadCallback(showCAzip);

            function showCAzip() {
                $.ajax({
                    url: "CAzipServlet",
                    //data: {"datedeb": $("datedeb").val(), "datefin": $("datefin").val()},
                    data: $("#dates").serialize(),
                    dataType: "json",
                    success:
                            function (result) {
                                console.log(result);
                                var chartData = [];
                                // On met le descriptif des données
                                chartData.push(["Code postal", "Ventes"]);
                                for (var zip in result.records) {
                                    chartData.push([zip, result.records[zip]]);
                                }

                                var data = google.visualization.arrayToDataTable(chartData);
                                var options = {
                                    title: "Chiffre d'affaire par code postal",
                                    hAxis: {title: "Code postal des clients"},
                                    vAxis: {title: "Chiffre d'affaire"},
                                };
                                var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
                                chart.draw(data, options);
                            },

                    error: showError
                });
            }

            // Fonction qui traite les erreurs de la requête
            function showError(xhr) {
                alert(JSON.parse(xhr.responseText).message);
            }
        </script>
    </head>
    <body>
        <h1 style="padding: 20px 0 30px 0;">Chiffre d'affaire par zone géographique</h1>

        <nav>
            <ul id="menu">
                <li><a href="admin.jsp">Accueil</a></li>
                <li><a href="product.jsp">Chiffre d'affaire par produits</a></li>
                <li><a class="active" href="zone.jsp">Chiffre d'affaire par états</a></li>
                <li><a href="CAclient.jsp">Chiffre d'affaire par clients</a></li>
            </ul>
        </nav>
        <form id="dates" onsubmit="event.preventDefault();" method="POST">
            Date début : <input id="datedeb" class="dateTrie" name="datedeb" type="date" value="2011-01-01">
            Date de fin : <input id="datefin" class="dateTrie" name="datefin" type="date" value="2019-01-01">
            <input class='valider' type='submit' name='boutonValider' value='Valider' onclick="showCAzone(), showCAzip()">

        </form>

        <div id="piechart" class="statistique" ></div>
        <div id="columnchart_values" class="statistique" ></div>
    </body>
</html>
