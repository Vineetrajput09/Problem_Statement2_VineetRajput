<%@ page import="java.sql.*" %>
<%
if (session.getAttribute("userEmail") == null) {
    response.sendRedirect("index.html");
    return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Diseases List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .navbar { font-size: 1.2rem; }
        .table-container { margin: 20px; }
        .table { margin-top: 20px; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg bg-white shadow py-3">
        <div class="container-fluid">
            <a class="navbar-brand text-primary fs-4" href="#">HealthCare</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link text-primary fs-5" href="doctor_dashboard.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link text-primary fs-5" href="doctorAppointments.jsp">Appointments</a></li>
                    <li class="nav-item"><a class="nav-link text-primary fs-5" href="diseases.jsp">Diseases</a></li>
                    <li class="nav-item"><a class="nav-link fs-5" href="#">About</a></li>
                </ul>
                <a href="logout.jsp" class="btn btn-danger fs-5">Logout</a>
            </div>
        </div>
    </nav>
    
    <div class="container table-container">
        <h1 class="text-left my-4">Diseases List</h1>
        <a href="AddMore.html" class="btn btn-success mb-3">Add More</a>
        <div class="table-responsive">
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>Disease</th>
                        <th>Symptoms 1</th>
                        <th>Symptoms 2</th>
                        <th>Symptoms 3</th>
                        <th>Medicine</th>
                        <th>Treatment</th>
                        <th>Notes</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Hackathon", "root", "Vineet@098");
                        PreparedStatement pstmt = con.prepareStatement("SELECT * FROM diseases");
                        ResultSet rs = pstmt.executeQuery();
                        while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getString("disease") %></td>
                        <td><%= rs.getString("symtons_1") %></td>
                        <td><%= rs.getString("symtons_2") %></td>
                        <td><%= rs.getString("symtons_3") %></td>
                        <td><%= rs.getString("medicine") %></td>
                        <td><%= rs.getString("treatement") %></td>
                        <td><%= rs.getString("notes") %></td>
                    </tr>
                    <%
                        }
                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    %>
                </tbody>
            </table>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
