<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Doctor Appointments</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

    <nav class="navbar navbar-expand-lg bg-white shadow py-4">
        <div class="container-fluid">
          <a class="navbar-brand text-primary fs-4" href="#">HealthCare</a> <!-- Larger Font -->
          <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
            <span class="navbar-toggler-icon"></span>
          </button>
          
          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
              <li class="nav-item"><a class="nav-link text-primary fs-5" href="doctor_dashboard.jsp">Home</a></li>
              <li class="nav-item"><a class="nav-link text-primary fs-5" href="doctorAppointments.jsp">Appointments</a></li>
              <li class="nav-item"><a class="nav-link text-primary fs-5" href="diseases.jsp">Diseases</a></li>
              <li class="nav-item"><a class="nav-link text-primary fs-5" href="#">About</a></li>
            </ul>
            <a href="logout.jsp" class="btn btn-danger fs-5">Logout</a>
          </div>
        </div>
      </nav>

    <div class="container mt-4">
        <h2 class="text-primary">My Appointments</h2>
        
        <% 
            // Get logged-in doctor's email
            String doctorEmail = (String) session.getAttribute("userEmail");
            if (doctorEmail == null) {
                response.sendRedirect("login.jsp"); 
                return;
            }
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Hackathon", "root", "Vineet@098");

                // Fetch appointments for the logged-in doctor
                PreparedStatement pst = con.prepareStatement(
                    "SELECT a.appointment_date, a.appointment_time, u.name AS patient_name, u.email AS patient_email " +
                    "FROM appointments a " +
                    "JOIN users u ON a.patient_email = u.email " +
                    "WHERE a.doctor_email = ?"
                );
                pst.setString(1, doctorEmail);
                ResultSet rs = pst.executeQuery();

                int totalAppointments = 0;
        %>

        <table class="table table-bordered mt-3">
            <thead class="table-dark">
                <tr>
                    <th>#</th>
                    <th>Patient Name</th>
                    <th>Patient Email</th>
                    <th>Appointment Date</th>
                    <th>Appointment Time</th>
                </tr>
            </thead>
            <tbody>
                <% while (rs.next()) { totalAppointments++; %>
                    <tr>
                        <td><%= totalAppointments %></td>
                        <td><%= rs.getString("patient_name") %></td>
                        <td><%= rs.getString("patient_email") %></td>
                        <td><%= rs.getDate("appointment_date") %></td>
                        <td><%= rs.getString("appointment_time") %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>

        <% 
            rs.close();
            pst.close();

            // Query to get the count of unique patients for this doctor
            PreparedStatement countPatientsPst = con.prepareStatement(
                "SELECT COUNT(DISTINCT patient_email) AS total_patients FROM appointments WHERE doctor_email = ?"
            );
            countPatientsPst.setString(1, doctorEmail);
            ResultSet countRs = countPatientsPst.executeQuery();
            int totalPatients = 0;
            if (countRs.next()) {
                totalPatients = countRs.getInt("total_patients");
            }
            countRs.close();
            countPatientsPst.close();
            con.close();
        %>

        <h4 class="mt-3">Total Appointments: <%= totalAppointments %></h4>
        <h4 class="mt-3 text-success">Total Unique Patients: <%= totalPatients %></h4>

        <% } catch (Exception e) { %>
            <p class="text-danger">Error loading appointments.</p>
        <% } %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
