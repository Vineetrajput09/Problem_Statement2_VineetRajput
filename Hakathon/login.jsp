<%@ page import="java.sql.*, java.security.MessageDigest, java.util.Base64" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
</head>
<body bgcolor="lightgray">
    <%
    // Get form data
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    try {
        // Hash the entered password using SHA-256
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hashedPasswordBytes = md.digest(password.getBytes("UTF-8"));
        String hashedPasswordBase64 = Base64.getEncoder().encodeToString(hashedPasswordBytes);

        // Load MySQL JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish Database Connection
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Hackathon", "root", "Vineet@098");

        // Fetch user details from the database
        PreparedStatement pst = con.prepareStatement("SELECT password, role FROM users WHERE email=?");
        pst.setString(1, email);
        ResultSet rs = pst.executeQuery();

        if (rs.next()) {
            String storedHashedPassword = rs.getString("password");
            String role = rs.getString("role");

            // Compare hashed passwords
            if (storedHashedPassword.equals(hashedPasswordBase64)) {
                session.setAttribute("userEmail", email);
                // session.setAttribute("username", name);
                session.setAttribute("userRole", role);

                // Redirect based on user role
                if (role.equals("Admin")) {
                    response.sendRedirect("admin_dashboard.jsp");
                } else if (role.equals("Doctor")) {
                    response.sendRedirect("doctor_dashboard.jsp");
                } else {
                    response.sendRedirect("patient_dashboard.jsp");
                }
            } else {
                out.println("<script>alert('Invalid User or Password'); window.location.href='index.html';</script>");

            }
        } else {
            out.println("<script>alert('Invalid User or Password'); window.location.href='index.html';</script>");

        }

        con.close();
    } catch (Exception e) {
        out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
    }
    %>
</body>
</html>
