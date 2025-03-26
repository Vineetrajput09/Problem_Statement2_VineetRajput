<%@ page import = "java.sql.* , java.security.MessageDigest, java.util.Base64" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup</title>
</head>
<body bgcolor="lightgray">
    <%
    // Get form data
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String role = request.getParameter("role");  
    String specialization = request.getParameter("specialization");

    // Default specialization as NULL if the user is a patient
    if ("Patient".equals(role)) {
        specialization = null;
    }

    try {   
        // Hash the password using SHA-256
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hashedPassword = md.digest(password.getBytes("UTF-8"));
        String hashedPasswordBase64 = Base64.getEncoder().encodeToString(hashedPassword);
     
        // Load MySQL JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // Establish Database Connection
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Hackathon", "root", "Vineet@098");

        // Prepare SQL query
        String query = "INSERT INTO users (name, email, password, role, specialization) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement pst = con.prepareStatement(query);
        pst.setString(1, name);
        pst.setString(2, email);
        pst.setString(3, hashedPasswordBase64); // Store hashed password
        pst.setString(4, role);
        pst.setString(5, specialization);

        // Execute the query
        int result = pst.executeUpdate();

        // Redirect on successful signup
        if (result > 0) {
            response.sendRedirect("admin_dashboard.jsp?signup=success"); // Pass success message
        } else {
            out.print("<h3 style='color:red;'>Signup unsuccessful. Please try again.</h3>");
        }

        // Close connection
        pst.close();
        con.close();

    } catch (ClassNotFoundException e) {
        out.println("<h3 style='color:red;'>Database Driver Error: " + e.getMessage() + "</h3>");
    } catch (SQLException e) {
        out.println("<h3 style='color:red;'>Error: Email already exists or database issue. " + e.getMessage() + "</h3>");
    }
    %>
</body>
</html>
