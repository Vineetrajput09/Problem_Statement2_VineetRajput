<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Appointments</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        .navbar { font-size: 1.2rem; } /* Increase Navbar Text Size */
        .table-container { margin-top: 50px; } /* Add spacing */
        .table { text-align: center; } /* Center align table content */
        .table thead { background-color: #007bff; color: white; } /* Table header styling */
        .table-hover tbody tr:hover { background-color: #f1f1f1; } /* Row hover effect */
        .status-pending { color: orange; font-weight: bold; }
        .status-confirmed { color: green; font-weight: bold; }
        .status-cancelled { color: red; font-weight: bold; }
    </style>
</head>
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

    <%@ page import="java.sql.*" %>

    <!-- 🟢 Table Section -->
    <div class="container table-container">
        <h2 class="text-center text-primary mb-4">My Appointments</h2>
        <div class="table-responsive">
            <table class="table table-hover table-bordered">
                <thead>
                    <tr>
                        <th>Doctor</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String patientEmail = (String) session.getAttribute("userEmail");
                        
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Hackathon", "root", "Vineet@098");
                            PreparedStatement pst = con.prepareStatement(
                                "SELECT a.*, u.name AS doctor_name FROM appointments a " +
                                "JOIN users u ON a.doctor_email = u.email WHERE a.patient_email=?"
                            );
                            pst.setString(1, patientEmail);
                            ResultSet rs = pst.executeQuery();

                            while (rs.next()) {
                                String statusClass = "status-pending"; // Default color
                                if (rs.getString("status").equalsIgnoreCase("Confirmed")) {
                                    statusClass = "status-confirmed";
                                } else if (rs.getString("status").equalsIgnoreCase("Cancelled")) {
                                    statusClass = "status-cancelled";
                                }
                    %>
                        <tr>
                            <td><%= rs.getString("doctor_name") %> (<%= rs.getString("doctor_email") %>)</td>
                            <td><%= rs.getString("appointment_date") %></td>
                            <td><%= rs.getString("appointment_time") %></td>
                            <td class="<%= statusClass %>"><%= rs.getString("status") %></td>
                        </tr>
                    <%
                            }
                            con.close();
                        } catch (Exception e) {
                            out.println("<tr><td colspan='4' class='text-danger text-center'>Error: " + e.getMessage() + "</td></tr>");
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 🟢 Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- 🟢 JavaScript for Appointment Success Alert -->
    <script>
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get("appointment") === "success") {
            alert("Appointment booked successfully!");
        }
    </script>

</body>
</html>
