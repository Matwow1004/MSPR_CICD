<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Recherche, Modification et Ajout de Films</title>
</head>
<body>
    <h1>Cherche ton film ici</h1>

    <form method="get" action="">
        Entrez une année : <input type="number" name="annee" placeholder="Entrez une année">
        <input type="submit" value="Rechercher">
    </form>

    <div id="resultat">
        <% 
        String anneeRecherchee = request.getParameter("annee");

        if (anneeRecherchee != null && !anneeRecherchee.isEmpty()) {
            String url = "jdbc:mariadb://localhost:3306/films";
            String user = "mysql";
            String password = "mysql";

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("org.mariadb.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);

                String sql = "SELECT idFilm, titre, année FROM Film WHERE année = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(anneeRecherchee));

                rs = pstmt.executeQuery();

                while (rs.next()) {
                    String colonne1 = rs.getString("idFilm");
                    String colonne2 = rs.getString("titre");
                    String colonne3 = rs.getString("année");
                    out.println("id : " + colonne1 + ", titre : " + colonne2 + ", année : " + colonne3 + "<br>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else if (request.getParameter("annee") != null) {
            out.println("Veuillez entrer une année.");
        }
        %>
    </div>

    <h1>Modification de Titre de Film</h1>

    <form method="post" action="">
        ID du Film à Modifier: 
        <input type="text" name="filmId" />
        Nouveau Titre: 
        <input type="text" name="nouveauTitre" />
        <input type="submit" value="Modifier Titre" />
    </form>

    <div id="resultatModification">
        <% 
        // Your modification code here
        %>
    </div>

    <h1>Ajout d'un Nouveau Film</h1>

    <form method="post" action="">
        Titre du Film: 
        <input type="text" name="titre" required/><br>

        Année de Sortie: 
        <input type="text" name="annee" required/><br>

        Genre:
        <input type="text" name="genre" required/><br>

        Résumé:
        <textarea name="resume" rows="4" cols="50" required></textarea><br>

        Réalisateur:
        <input type="text" name="realisateur" required/><br>

        Pays:
        <input type="text" name="pays" required/><br>

        <input type="submit" value="Ajouter Film" />
    </form>

    <div id="resultatAjout">
        <%  
        // Your code for adding a new film here
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String titre = request.getParameter("titre");
            String annee = request.getParameter("annee");
            String genre = request.getParameter("genre");
            String resume = request.getParameter("resume");
            String realisateur = request.getParameter("realisateur");
            String pays = request.getParameter("pays");

            // Your code to insert the new film into the database goes here
            // You can use a PreparedStatement to execute an INSERT query
            // Make sure to handle exceptions appropriately
        }
        %>
    </div>
</body>
</html> 
