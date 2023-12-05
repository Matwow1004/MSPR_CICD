<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manipulation de films</title>
</head>
<body>

    <!-- Recherche de films par année -->
    <h1>Recherche de films par année</h1>
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

    <!-- Modification du titre d'un film par ID -->
    <h1>Modification du titre d'un film par ID</h1>
    <form method="post" action="">
        Entrez l'ID du film : <input type="number" name="idFilm" placeholder="Entrez l'ID du film">
        Nouveau titre : <input type="text" name="nouveauTitre" placeholder="Nouveau titre">
        <input type="submit" value="Modifier">
    </form>
    <div id="resultat">
        <% 
        String idFilm = request.getParameter("idFilm");
        String nouveauTitre = request.getParameter("nouveauTitre");

        if (idFilm != null && nouveauTitre != null && !idFilm.isEmpty() && !nouveauTitre.isEmpty()) {
            String url = "jdbc:mariadb://localhost:3306/films";
            String user = "mysql";
            String password = "mysql";

            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("org.mariadb.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);

                String sql = "UPDATE Film SET titre = ? WHERE idFilm = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, nouveauTitre);
                pstmt.setInt(2, Integer.parseInt(idFilm));

                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("Le titre du film avec l'ID " + idFilm + " a été modifié avec succès.");
                } else {
                    out.println("Aucun film trouvé avec cet ID.");
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
        } else if (idFilm != null || nouveauTitre != null) {
            out.println("Veuillez entrer à la fois l'ID du film et le nouveau titre.");
        }
        %>
    </div>

    <!-- Création d'un nouveau film -->
    <h1>Création d'un nouveau film</h1>
    <form method="post" action="">
        Titre : <input type="text" name="nouveauTitre" placeholder="Titre du film">
        Année : <input type="number" name="nouvelleAnnee" placeholder="Année du film">
        <!-- Ajoutez d'autres champs ici pour d'autres informations sur le film -->
        <input type="submit" value="Ajouter">
    </form>
    <div id="resultat">
        <% 
        String nouveauTitre = request.getParameter("nouveauTitre");
        String nouvelleAnnee = request.getParameter("nouvelleAnnee");

        if (nouveauTitre != null && nouvelleAnnee != null && !nouveauTitre.isEmpty() && !nouvelleAnnee.isEmpty()) {
            String url = "jdbc:mariadb://localhost:3306/films";
            String user = "mysql";
            String password = "mysql";

            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("org.mariadb.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);

                String sql = "INSERT INTO Film (titre, année) VALUES (?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, nouveauTitre);
                pstmt.setInt(2, Integer.parseInt(nouvelleAnnee));

                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("Le film '" + nouveauTitre + "' a été ajouté avec succès.");
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
        } else if (nouveauTitre != null || nouvelleAnnee != null) {
            out.println("Veuillez remplir tous les champs pour ajouter un nouveau film.");
        }
        %>
    </div>
</body>
</html>
