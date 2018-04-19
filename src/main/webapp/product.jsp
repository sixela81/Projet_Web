
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/x-icon" href="images/admin.ico">
        <title>CA par produits</title>
        <script	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/mustache.js/0.8.1/mustache.min.js"></script>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <link rel="stylesheet" type="text/css" href="css/pageAdmin.css">
        <script>
            $(document).ready(// Exécuté à la fin du chargement de la page
                    function () {
                        showCAproduct();
                    }
            );

            google.charts.load('current', {'packages': ['corechart']});
            google.charts.setOnLoadCallback(showCAproduct);

            function showCAproduct() {
                $.ajax({
                    url: "CAproductServlet",
                    data: $("#dates").serialize(),
                    dataType: "json",
                    success:
                            function (result) {
                                var chartData = [];
                                // On met le descriptif des données
                                chartData.push(["Produits", "Ventes"]);
                                for (var product in result.records) {
                                    chartData.push([product, result.records[product]]);
                                }

                                var data = google.visualization.arrayToDataTable(chartData);

                                var options = {
                                    title: "Chiffre d'affaire par produit",
                                    pieHole: 0.5,
                                };

                                var chart = new google.visualization.PieChart(document.getElementById('circle'));
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
        <h1 style="padding: 20px 0 30px 0;">Chiffre d'affaire par produits</h1>

        <nav>
            <ul id="menu">
                <li><a href="admin.jsp">Accueil</a></li>
                <li><a class="active" href="product.jsp">Chiffre d'affaire par produits</a></li>
                <li><a href="zone.jsp">Chiffre d'affaire par états</a></li>
                <li><a href="CAclient.jsp">Chiffre d'affaire par clients</a></li>
            </ul>
        </nav>
        <form id="dates" onsubmit="event.preventDefault();" method="POST">
            Date début : <input id="datedeb" name="datedeb" type="date" value="2011-01-01">
            Date de fin : <input id="datefin" name="datefin" type="date" value="2019-01-01">
            <input class='valider' type='submit' name='boutonValider' value='Valider' onclick="showCAproduct()">
        </form>
        <div id="circle" class="statistique"></div>
    </body>
</html>
