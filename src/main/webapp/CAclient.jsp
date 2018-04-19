<%-- 
    Document   : CAclient
    Created on : 11 mars 2018, 19:20:02
    Author     : alexi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/x-icon" href="images/admin.ico">
        <title>CA par clients</title>
        <!-- On charge jQuery -->
        <script	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <!-- On charge le moteur de template mustache https://mustache.github.io/ -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/mustache.js/0.8.1/mustache.min.js"></script>
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <link rel="stylesheet" type="text/css" href="css/pageAdmin.css">
        <script>
                    $(document).ready(// Exécuté à la fin du chargement de la page
                            function () {
                                showCAclient();
                            }
                    );
                    
                    google.charts.load('current', {'packages':['corechart']});
                    google.charts.setOnLoadCallback(showCAclient);
                    
                    function showCAclient() {
                        $.ajax({
                            url: "ChiffreAffairecustomer",
                            data: $("#dates").serialize(),
                            dataType: "json",
                            success:
                                    function(result) {
                                        //console.log(result);
                                        
                                        var chartData = [];
						// On met le descriptif des données
						chartData.push(["Client", "Ventes"]);
						for(var client in result.records) {
							chartData.push([client, result.records[client]]);
						}
                                        
                                        //camembert ------------------------------------------------------------------------
                                        var data = google.visualization.arrayToDataTable(chartData);
                                        
                                        var options = {
                                                title: "Chiffre d'affaire par clients",
                                                is3D: true
                                        };

                                        var chart = new google.visualization.PieChart(document.getElementById('piechart'));

                                        chart.draw(data, options);
                                        
                                        //scatter ------------------------------------------------------------------------
                                        var data2 = google.visualization.arrayToDataTable(chartData);

                                        var options2 = {
                                            title: "Chiffre d'affaire par client",
                                            hAxis: {title: 'Clients'},
                                            vAxis: {title: "Chiffre d'affaire"}
                                        };

                                        var chart2 = new google.visualization.ScatterChart(document.getElementById('scatterchart'));

                                        chart2.draw(data2, options2);
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
        <h1 style="padding: 20px 0 30px 0;">Chiffre d'affaire par clients</h1>
            <nav>
                    <ul id="menu">
                        <li><a href="admin.jsp">Accueil</a></li>
                        <li><a href="product.jsp">Chiffre d'affaire par produits</a></li>
                        <li><a href="zone.jsp">Chiffre d'affaire par états</a></li>
                        <li><a class="active" href="CAclient.jsp">Chiffre d'affaire par clients</a></li>
                    </ul>
            </nav>
            <form id="dates" onsubmit="event.preventDefault();" method="POST">
                Date début : <input id="datedeb" name="datedeb" type="date" value="2011-01-01">
                Date de fin : <input id="datefin" name="datefin" type="date" value="2019-01-01">
                <input class='valider' type='submit' name='boutonValider' value='Valider' onclick="showCAclient()">

            </form>
            <div id="piechart" class="statistique" ></div>
            <div id="scatterchart" class="statistique" ></div>
    </body>
</html>
