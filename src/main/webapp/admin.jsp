<%-- 
    Document   : admin
    Created on : 27 févr. 2018, 13:20:52
    Author     : cptbo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/x-icon" href="images/admin.ico">
        <title>Session Administrateur</title>
        <!-- On charge jQuery -->
        <script	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <!-- On charge le moteur de template mustache https://mustache.github.io/ -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/mustache.js/0.8.1/mustache.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/pageAdmin.css">
        <script>
            $(document).ready(// Exécuté à la fin du chargement de la page
                    function () {
                        // On montre la liste des codes
                        showCodes();
                        showProducts();
                    }
            );

            function showCodes() {
                // On fait un appel AJAX pour chercher les codes
                $.ajax({
                    url: "allCodes",
                    dataType: "json",
                    error: showError,
                    success: // La fonction qui traite les résultats
                            function (result) {
                                // Le code source du template est dans la page
                                var template = $('#codesTemplate').html();
                                // On combine le template avec le résultat de la requête
                                var processedTemplate = Mustache.to_html(template, result);
                                // On affiche la liste des options dans le select
                                $('#codes').html(processedTemplate);

                                document.getElementById("Modifier").disabled = true;

                                //double click pour modifier
                                $("tbody TR").dblclick(function (event) {
                                    var ligne = $(this).parent().context.innerText;
                                    ligneSelectionne = ligne.split("	");
                                    modeModifier(ligneSelectionne);
                                });

                                //bouton effacer
                                $("#ToutEffacer").click(function (event) {
                                    toutEffacer();
                                });
                            }
                });
            }

            // Ajouter un code
            function addCode() {
                $.ajax({
                    url: "addCode",
                    // serialize() renvoie tous les paramètres saisis dans le formulaire
                    data: $("#codeForm").serialize(),
                    dataType: "json",
                    success: // La fonction qui traite les résultats
                            function (result) {
                                showCodes();
                                console.log(result);
                                toutEffacer();
                                var mes = document.getElementById("messageAjout");
                                mes.innerHTML = result.message;
                            },
                    error: showError
                });
                return false;
            }

            function modify() {
                $.ajax({
                    url: "Modify",
                    data: $("#codeForm").serialize(),
                    dataType: "json",
                    success:
                            function (result) {
                                showCodes();
                                console.log(result); // faire une fenetre popup
                                toutEffacer();
                            },
                    error: showError
                });

            }

            // Supprimer un code
            function deleteCode(code) {
                $.ajax({
                    url: "deleteCode",
                    data: {"code": code},
                    dataType: "json",
                    success:
                            function (result) {
                                alert("Bon de commande supprimé");
                                showCodes();
                                console.log(result);
                            },
                    error: showError
                });
                return false;
            }

            //affiche les produits existant
            function showProducts() {
                $.ajax({
                    url: "allProducts",
                    dataType: "json",
                    error: showError,
                    success:
                            function (result) {
                                //console.log(result);
                                //console.log(result.prod[0]);
                                var sel = document.getElementById("prodid");
                                for (var i = 0; i < result.prod.length; i++) {
                                    var opt = document.createElement("option");
                                    opt.value = result.prod[i].id;
                                    opt.text = result.prod[i].id + " : " + result.prod[i].description;
                                    sel.add(opt, null);
                                }
                            }
                });
            }

            function modeModifier(ligneSelectionne) {
                document.getElementById("Ajouter").disabled = true;
                document.getElementById("Modifier").disabled = false;

                var numCo = document.getElementById("code");
                numCo.value = ligneSelectionne[0];
                numCo.setAttribute("readonly", "readonly");

                var client = document.getElementById("taux");
                client.value = ligneSelectionne[1];
                var produitId = document.getElementById("prodid");
                produitId.value = ligneSelectionne[2];
                var quantite = document.getElementById("quantite");
                quantite.value = ligneSelectionne[3];
                var fraisP = document.getElementById("fraisP");
                fraisP.value = ligneSelectionne[4];
                var dateV = document.getElementById("dateV");
                dateV = ligneSelectionne[5];
                var dateE = document.getElementById("dateE");
                dateE = ligneSelectionne[6];
                var transport = document.getElementById("transport");
                transport.value = ligneSelectionne[7];

                numCo.focus();

            }

            function toutEffacer() {
                if (document.getElementById("Ajouter").disabled === true) {
                    document.getElementById("Ajouter").disabled = false;
                }
                if (document.getElementById("Modifier").disabled === false) {
                    document.getElementById("Modifier").disabled = true;
                }
                if (document.getElementById("code").getAttribute("readonly") === "readonly") {
                    document.getElementById("code").removeAttribute("readonly");
                }
                var numCo = document.getElementById("code");
                numCo.value = null;
                var clientID = document.getElementById("taux");
                clientID.value = null;
                var quantite = document.getElementById("quantite");
                quantite.value = null;
                var fraisP = document.getElementById("fraisP");
                fraisP.value = null;
                var dateV = document.getElementById("dateV");
                dateV.value = null;
                var dateE = document.getElementById("dateE");
                dateE.value = null;
                var transport = document.getElementById("transport");
                transport.value = null;
            }

            // Fonction qui traite les erreurs de la requête
            function showError(xhr, status, message) {
                alert(JSON.parse(xhr.responseText).message);
            }

        </script>

    </head>
    <body>

        <h1>Bienvenue <span id='ad'>Administrateur</span></h1>

        <h2>Consulter : </h2>
        <nav>
            <ul id="menu">
                <li><a class="active" href="admin.jsp">Accueil</a></li>
                <li><a href="product.jsp">Chiffre d'affaire par produits</a></li>
                <li><a href="zone.jsp">Chiffre d'affaire par zones</a></li>
                <li><a href="CAclient.jsp">Chiffre d'affaire par clients</a></li>
            </ul>
        </nav>

        <h2 id="titreTab">Tableau de tous les clients : </h2>
        <p style="text-align: center; margin-bottom: 20px;">Double-click sur la ligne à modifier</p>

        <!-- La zone où les résultats vont s'afficher -->
        <div id="codes"></div>
        <!-- Le template qui sert à formatter la liste des codes -->
        <script id="codesTemplate" type="text/template">
            <TABLE id="tableau">
            <tr><th>Numéro du bon de commande</th><th>Client ID</th><th>ID du Produit</th><th>Quantite</th><th>Frais de port</th><th>Date de vente</th><th>Date d'expédition</th><th>Société de transport</th><th>Action</th></tr>
            {{! Pour chaque enregistrement }}
            {{#records}}
            {{! Une ligne dans la table }}
            <TR><TD>{{orderNum}}</TD><TD>{{customerId}}</TD><TD>{{productID}}</TD><TD>{{quantity}}</TD><TD>{{shippingCost}}</TD><TD>{{salesDate}}</TD><TD>{{shippingDate}}</TD><TD>{{freightCompany}}</TD><TD><button class="supprimer" onclick="deleteCode('{{orderNum}}')">Supprimer</button></TD></TR>
            {{/records}}
            </TABLE>
        </script>

        <div id="messageAjout"></div>
        <!-- On montre le formulaire de saisie -->
        <h2>Edition d'un bon de commande : </h2>
        <div class="bg-container-contact100" style="background-image: url(images/bg-01.jpg);" ></div>
        <div class="container-contact100">
            <div class="wrap-contact100">
                <div class="contact100-form-title" style="background-image: url(images/bg-01.jpg);">
                    <span>Votre nouveau bon de commande :</span>
                </div>

                <!--pour les icones-->
                <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
                <form id="codeForm" onsubmit="event.preventDefault();">

                    <div class="wrap-input100 validate-input">
                        Numéro du bon de commande : <input id="code" class="input100" name="code" type="number" required><br/>
                        <span class="focus-input100"></span>
                        <i class="material-icons">edit</i>
                    </div>
                    <div class="wrap-input100 validate-input">      
                        Numéro du client : <input id="taux" class="input100" name="taux" required><br/>
                        <span class="focus-input100"></span>
                        <i class="material-icons">assignment_ind</i>
                    </div>
                    <div class="wrap-input100 validate-input">
                        ID du Produit : <select id="prodid" class="input100" name="prodid" size="1" required style="border: 1px solid transparent;">
                        </select><br/>
                        <span class="focus-input100"></span>
                        <i class="material-icons">assignment_ind</i>
                    </div>
                    <div class="wrap-input100 validate-input">
                        Quantité : <input id="quantite" class="input100" name="quantite" type="number" required><br/>
                        <span class="focus-input100"></span>
                        <i class="material-icons">shopping_cart</i>
                    </div>
                    <div class="wrap-input100 validate-input">
                        Frais de port : <input id="fraisP" class="input100" name="fraisP" type="number" required><br/>
                        <span class="focus-input100"></span>
                        <i class="material-icons">euro_symbol</i>
                    </div>
                    <div class="wrap-input100 validate-input">
                        Date de vente : <input id="dateV" class="input100" name="dateVente" type="date" required><br/>
                        <span class="focus-input100"></span>
                        <i class="material-icons">today</i>
                    </div>
                    <div class="wrap-input100 validate-input">
                        Date d'expédition : <input id="dateE" class="input100" name="dateExp" type="date" required><br/>
                        <span class="focus-input100"></span>
                        <i class="material-icons">send</i>
                    </div>
                    <div class="wrap-input100 validate-input">
                        Société de transport : <input id="transport" class="input100" name="transport" type="text" size="40" required><br/>
                        <span class="focus-input100"></span>
                        <i class="material-icons">local_shipping</i>
                    </div>
                    <div class="container-contact100-form-btn">    
                        <input type="submit" id="Ajouter" class="contact100-form-btn" value="Ajouter" onclick="addCode()">
                    </div>
                    <div class="container-contact100-form-btn">
                        <input type="submit" id="Modifier" class="contact100-form-btn" value="Modifier" onclick="modify()">
                    </div>
                    <div class="container-contact100-form-btn">
                        <input type="submit" id="ToutEffacer" class="contact100-form-btn" value="Annuler modifier">
                    </div>
                </form>
            </div>     
        </div>

        <form action="<c:url value="/"/>" method="POST"> 
            <input class="deconnexion" type='submit' name='boutonConnexion' value='Se deconnecter'>
        </form>


    </body>
</html>

