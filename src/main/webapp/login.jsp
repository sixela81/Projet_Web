<%@page contentType="text/html" pageEncoding="UTF-8" session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" type="image/x-icon" href="images/box2.ico">
        <title>Please login</title>
        <!-- On charge jQuery -->
        <script	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <!-- On charge le moteur de template mustache https://mustache.github.io/ -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/mustache.js/0.8.1/mustache.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/connexion.css">
    </head>
    <body>
        <div class="limiter">
            <div id="bg" class="container-login100">
                <div class="wrap-login100">
                    <form class="login100-form validate-form" action="<c:url value="/" />" method="POST"> 
                        <!-- l'action par défaut est l'URL courant, qui va rappeler la servlet -->
                        <span class="login100-form-title p-b-26">
                            Bienvenue
                        </span>
                        <!-- oeil du password -->
                        <span class="login100-form-title p-b-48">
                            <i class="zmdi zmdi-font"></i>
                        </span>
                        <%--
                        La servlet fait : request.setAttribute("errorMessage", "Login/Password incorrect");
                        La JSP récupère cette valeur dans ${errorMessage}
                        --%>
                        <%--
                        <div id="error">${messageErreur}</div>
                        --%>
                        <div id="error" style="color: red">${messageErreur}</div>

                        <div class="wrap-input100 validate-input" data-validate = "Valid email is: a@b.c">
                            <input class="input100" type="text" name="utilisateurParam" placeholder="Email">
                            <span class="focus-input100" data-placeholder="Email"></span>
                        </div>

                        <div class="wrap-input100 validate-input" data-validate="Enter password">
                            <input class="input100" type="password" name="motdepasseParam" placeholder="Mot de passe">
                            <span class="focus-input100" data-placeholder="Password"></span>
                        </div>

                        <div class="container-login100-form-btn">
                            <div class="wrap-login100-form-btn">
                                <div class="login100-form-bgbtn"></div>
                                <button class="login100-form-btn" name="boutonConnexion" value="Se connecter">Connexion
                                </button>
                            </div>
                        </div>


                    </form>
                </div>
            </div>
        </div>

        <ul class="bg-bubbles">
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ul>
        <div id="dropDownSelect1"></div>
        <!--===============================================================================================-->
        <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
        <script src="js/login.js"></script>
    </body>
</html>
