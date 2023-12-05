<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Recherche de films par année</title>
</head>
<body>
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
</body>
</html>
