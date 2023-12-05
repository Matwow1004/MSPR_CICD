<!-- ... (votre code existant) ... -->

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
 
