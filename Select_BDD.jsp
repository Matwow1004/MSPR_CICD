<!DOCTYPE html>
<html>
<head>
    <title>Recherche de films par année</title>
</head>
<body>
    <h1>Recherche de films par année</h1>

    Entrez une année : <input type="text" id="annee">
    <button onclick="rechercherFilms()">Rechercher</button>

    <div id="resultat"></div>

    <script>
        function rechercherFilms() {
            var annee = document.getElementById('annee').value;
            var resultatDiv = document.getElementById('resultat');

            if (annee.trim() !== '') {
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            resultatDiv.innerHTML = xhr.responseText;
                        } else {
                            resultatDiv.innerHTML = 'Erreur lors de la requête.';
                        }
                    }
                };

                xhr.open('GET', 'traitement.jsp?annee=' + annee, true);
                xhr.send();
            } else {
                resultatDiv.innerHTML = 'Veuillez entrer une année.';
            }
        }
    </script>
</body>
</html>

