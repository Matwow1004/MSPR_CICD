<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Combined JSP</title>
</head>
<body>

    <!-- Recherche de films par année -->
    <!-- ... (Code existant pour la recherche de films par année) ... -->

    <!-- Modification du titre d'un film par ID -->
    <!-- ... (Code existant pour la modification du titre d'un film par ID) ... -->

    <!-- Ajout d'un nouveau film -->
    <h1>Ajout d'un nouveau film</h1>
    <form method="post" action="">
        ID du film : <input type="number" name="idFilmAjout" placeholder="ID du film"><br>
        Titre : <input type="text" name="titreAjout" placeholder="Titre du film"><br>
        Année : <input type="number" name="anneeAjout" placeholder="Année de sortie"><br>
        Genre : <input type="text" name="genreAjout" placeholder="Genre du film"><br>
        Résumé : <textarea name="resumeAjout" placeholder="Résumé du film"></textarea><br>
        ID du réalisateur : <input type="number" name="idRealisateurAjout" placeholder="ID du réalisateur"><br>
        Code pays : <input type="text" name="codePaysAjout" placeholder="Code pays"><br>
        <input type="submit" value="Ajouter">
    </form>
    
    <div id="resultatAjout">
        <% 
        String idFilmAjout = request.getParameter("idFilmAjout");
        String titreAjout = request.getParameter("titreAjout");
        String anneeAjout = request.getParameter("anneeAjout");
        String genreAjout = request.getParameter("genreAjout");
        String resumeAjout = request.getParameter("resumeAjout");
        String idRealisateurAjout = request.getParameter("idRealisateurAjout");
        String codePaysAjout = request.getParameter("codePaysAjout");

        if (idFilmAjout != null && titreAjout != null && anneeAjout != null && genreAjout != null &&
            resumeAjout != null && idRealisateurAjout != null && codePaysAjout != null &&
            !idFilmAjout.isEmpty() && !titreAjout.isEmpty() && !anneeAjout.isEmpty() && !genreAjout.isEmpty() &&
            !resumeAjout.isEmpty() && !idRealisateurAjout.isEmpty() && !codePaysAjout.isEmpty()) {

            String url = "jdbc:mariadb://localhost:3306/films";
            String user = "mysql";
            String password = "mysql";

            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("org.mariadb.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);

                String sql = "INSERT INTO Film (idFilm, titre, année, genre, résumé, idRéalisateur, codePays) VALUES (?, ?, ?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(idFilmAjout));
                pstmt.setString(2, titreAjout);
                pstmt.setInt(3, Integer.parseInt(anneeAjout));
                pstmt.setString(4, genreAjout);
                pstmt.setString(5, resumeAjout);
                pstmt.setInt(6, Integer.parseInt(idRealisateurAjout));
                pstmt.setString(7, codePaysAjout);

                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("Le film a été ajouté avec succès.");
                } else {
                    out.println("Erreur lors de l'ajout du film.");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else if (idFilmAjout != null || titreAjout != null || anneeAjout != null || genreAjout != null ||
                   resumeAjout != null || idRealisateurAjout != null || codePaysAjout != null) {
            out.println("Veuillez remplir tous les champs pour ajouter un nouveau film.");
        }
        %>
    </div>

    <!-- ... (Autres sections HTML pour les tables Pays, Artiste, Rôle, Internaute, Notation) ... -->

</body>
</html>

