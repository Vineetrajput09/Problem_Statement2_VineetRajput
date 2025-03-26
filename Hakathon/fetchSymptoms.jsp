<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
if (session.getAttribute("userEmail") == null) {
    // If not logged in, redirect to login page
    response.sendRedirect("index.html");
    return;
}%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dropdown Form</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>

<style>
    /* General Styles */
body {
    background: #f4f6f9;
    font-family: 'Poppins', sans-serif;
    margin: 0;
    padding: 0;
}



/* Form Container */
.form-container {
    background: #fff;
    max-width: 500px;
    margin: 100px auto;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

h3 {
    color: #007bff;
    text-align: center;
    margin-bottom: 20px;
}

/* Form Inputs */
.form-control {
    border-radius: 5px;
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ccc;
}

.form-select {
    border-radius: 5px;
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ccc;
}

/* Submit Button */
input[type="submit"] {
    width: 100%;
    padding: 12px;
    border: none;
    background: #007bff;
    color: #fff;
    font-size: 18px;
    font-weight: bold;
    border-radius: 5px;
    cursor: pointer;
    transition: 0.3s;
}

input[type="submit"]:hover {
    background: #0056b3;
}

/* Responsive Design */
@media (max-width: 768px) {
    .form-container {
        max-width: 90%;
    }
}

    </style>
<body>
    <nav class="navbar navbar-expand-lg bg-white shadow py-3">
        <div class="container">
            <a class="navbar-brand text-primary fs-4" href="#">HealthCare</a> <!-- Brand Name -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link text-primary fs-5" href="All_Doctors.jsp">All Doctors</a></li>
                    <li class="nav-item"><a class="nav-link text-primary fs-5" href="myAppointments.jsp">My Appointments</a></li>
                    <li class="nav-item"><a class="nav-link text-primary fs-5" href="fetchSymptoms.jsp">Medicines</a></li>
                    <li class="nav-item"><a class="nav-link text-primary fs-5" href="#">About</a></li>
                </ul>
                <a href="logout.jsp" class="btn btn-danger fs-5">Logout</a>
            </div>
        </div>
    </nav>

    <div class="form-container">
        <form action="submitSymptoms.jsp" method="get">
            <div class="dropdown">
                <h3>Patient Health</h3>
                <input class="form-control form-control" type="text" placeholder="Enter your name" name="name" aria-label=".form-control-lg example" style="margin-bottom: 20px;">
                <input class="form-control form-control" type="text" placeholder="Enter your age" name="age" aria-label=".form-control-lg example" style="margin-bottom: 20px;">
                <select class="form-select" aria-label="Default select example" name="sy1">
                    <option value="null">select a value</option>
                    <%
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Hackathon", "root", "Vineet@098");
                            stmt = conn.createStatement();
                            String sql = "SELECT symtons_1 FROM diseases";
                            rs = stmt.executeQuery(sql);

                            while (rs.next()) {
                                String symptom = rs.getString("symtons_1");
                                out.println("<option value='" + symptom + "'>" + symptom + "</option>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                  </select>
            
            <div class="dropdown">
                <select class="form-select" aria-label="Default select example" name="sy2">
                    <option value="null">select a value</option>
                    <%
                        

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Hackathon", "root", "Vineet@098");
                            stmt = conn.createStatement();
                            String sql = "SELECT symtons_2 FROM diseases";
                            rs = stmt.executeQuery(sql);

                            while (rs.next()) {
                                String symptom = rs.getString("symtons_2");
                                out.println("<option value='" + symptom + "'>" + symptom + "</option>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                  </select>
            <div class="dropdown">
                <select class="form-select" aria-label="Default select example" name="sy3">
                    <option value="null">select a value</option>
                    <%
                        

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Hackathon", "root", "Vineet@098");
                            stmt = conn.createStatement();
                            String sql = "SELECT symtons_3 FROM diseases";
                            rs = stmt.executeQuery(sql);

                            while (rs.next()) {
                                String symptom = rs.getString("symtons_3");
                                out.println("<option value='" + symptom + "'>" + symptom + "</option>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } 
                    %>
                  </select>
            </div>
             <input type="submit" value="submit">
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>
