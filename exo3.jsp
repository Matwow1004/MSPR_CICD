<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modification du titre d'un film par ID</title>
</head>
<body>
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
</body>
</html>

