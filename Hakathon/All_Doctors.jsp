<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Available Doctors</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

    <nav class="navbar navbar-expand-lg bg-white shadow py-3">
        <div class="container">
            <a class="navbar-brand text-primary fs-4" href="#">HealthCare</a>
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

    <div class="container mt-4">
        <div class="row">
            <% 
                String loggedInPatientEmail = (String) session.getAttribute("userEmail");
                if (loggedInPatientEmail == null) {
                    response.sendRedirect("login.jsp"); // Redirect if not logged in
                    return;
                }
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Hackathon", "root", "Vineet@098");
                    PreparedStatement pst = con.prepareStatement("SELECT name, email, specialization FROM users WHERE role = 'Doctor'");
                    ResultSet rs = pst.executeQuery();
                    while (rs.next()) { 
            %>
                    <div class="col-md-4 mb-4">
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <h5 class="card-title text-primary"><%= rs.getString("name") %></h5>
                                <p class="card-text"><strong>Specialization:</strong> <%= rs.getString("specialization") %></p>
                                <form action="bookAppointment.jsp" method="POST">
                                    <input type="hidden" name="doctor_email" value="<%= rs.getString("email") %>">
                                    
                                    <div class="mb-3">
                                        <label class="form-label">Your Email:</label>
                                        <input type="email" class="form-control" name="patient_email" value="<%= loggedInPatientEmail %>" readonly>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label class="form-label">Appointment Date:</label>
                                        <input type="date" class="form-control" name="appointment_date" id="appointmentDate" required>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label class="form-label">Appointment Time:</label>
                                        <select class="form-select" name="appointment_time" id="timeSlot" required>
                                            <option value="">-- Select Time --</option>
                                        </select>
                                    </div>
                                    
                                    <button type="submit" class="btn btn-success w-100">Book Appointment</button>
                                </form>
                            </div>
                        </div>
                    </div>
            <% 
                    } 
                    rs.close(); 
                    pst.close(); 
                    con.close();
                } catch (Exception e) { 
            %>
                <div class="col-12">
                    <p class="text-danger">Error loading doctors.</p>
                </div>
            <% } %>
        </div>
    </div>
    
<script>
    $(document).ready(function () {
        $("#appointmentDate").on("change", function () {
            var doctorEmail = $("input[name='doctor_email']").val();
            var appointmentDate = $(this).val();
            if (doctorEmail && appointmentDate) {
                $.ajax({
                    url: "fetchAvailableSlots.jsp",
                    type: "GET",
                    data: { doctor_email: doctorEmail, appointment_date: appointmentDate },
                    success: function (response) {
                        $("#timeSlot").html(response);
                    }
                });
            }
        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
