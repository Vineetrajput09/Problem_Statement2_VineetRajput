<%@ page import="java.sql.*" %>
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
    <title>HealthCare - Register</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .navbar { font-size: 1.2rem; } 
        p{
            display: none;
        }/* Increase Navbar Text Size */
        #specializationField { display: none; } /* Initially Hide Specialization */
    </style>
</head>
<body>

    <!-- 🟢 Navbar -->
    <nav class="navbar navbar-expand-lg bg-white shadow py-3">
        <div class="container">
            <a class="navbar-brand text-primary fs-4" href="#">HealthCare</a> <!-- Brand Name -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link fs-5" href="#">Medicines_Details</a></li>
                    <!-- Register Doctor/Patient with Modal Trigger -->
                    <li class="nav-item">
                        <a class="nav-link fs-5 text-primary" href="#" data-bs-toggle="modal" data-bs-target="#signupModal">
                            Register_Doctor/Patient
                        </a>
                    </li>
                    <li class="nav-item"><a class="nav-link fs-5" href="#" data-bs-toggle="modal" data-bs-target="#bookAppointmentModal">BookAppointment</a></li>
                </ul>
                <a href="logout.jsp" class="btn btn-danger fs-5">Logout</a>
            </div>
        </div>
    </nav>

    <p>Session Username: <%= session.getAttribute("userEmail") %></p>
    <!-- Modal for Booking Appointment -->
<div class="modal fade" id="bookAppointmentModal" tabindex="-1" aria-labelledby="bookAppointmentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-primary" id="bookAppointmentModalLabel">Book an Appointment</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="bookAppointment.jsp" method="POST">
                    <!-- Patient Selection -->
                    <div class="mb-3">
                        <label class="form-label" for="patientSelect">Select Patient:</label>
                        <select class="form-select" name="patient_email" id="patientSelect" required>
                            <option value="">-- Select Patient --</option>
                            <% try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Hackathon", "root", "Vineet@098");
                                PreparedStatement pst = con.prepareStatement("SELECT name, email FROM users WHERE role = 'Patient'");
                                ResultSet rs = pst.executeQuery();
                                while (rs.next()) { %>
                                    <option value="<%= rs.getString("email") %>">
                                        <%= rs.getString("name") %> (<%= rs.getString("email") %>)
                                    </option>
                            <% } rs.close(); pst.close(); con.close(); } catch (Exception e) { %>
                            <option disabled>Error loading patients</option>
                            <% } %>
                        </select>
                    </div>

                    <!-- Doctor Selection -->
                    <div class="mb-3">
                        <label class="form-label" for="doctorSelect">Select Doctor:</label>
                        <select class="form-select" name="doctor_email" id="doctorSelect" required>
                            <option value="">-- Select Doctor --</option>
                            <% try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Hackathon", "root", "Vineet@098");
                                PreparedStatement pst = con.prepareStatement("SELECT name, email, specialization FROM users WHERE role = 'Doctor'");
                                ResultSet rs = pst.executeQuery();
                                while (rs.next()) { %>
                                    <option value="<%= rs.getString("email") %>">
                                        <%= rs.getString("name") %> - <%= rs.getString("specialization") %>
                                    </option>
                            <% } rs.close(); pst.close(); con.close(); } catch (Exception e) { %>
                            <option disabled>Error loading doctors</option>
                            <% } %>
                        </select>
                    </div>

                    <!-- Appointment Date -->
                    <div class="mb-3">
                        <label class="form-label" for="appointmentDate">Appointment Date:</label>
                        <input type="date" class="form-control" name="appointment_date" id="appointmentDate" required>
                    </div>

                    <!-- Appointment Time -->
                    <div class="mb-3">
                        <label class="form-label" for="timeSlot">Appointment Time:</label>
                        <select class="form-select" name="appointment_time" id="timeSlot" required>
                            <option value="">-- Select Time --</option>
                        </select>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-success px-4">Book Appointment</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
    
    
    

    <!-- 🟢 Signup Modal -->
    <div class="modal fade" id="signupModal" tabindex="-1" aria-labelledby="signupModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title text-primary">Sign Up</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="signup.jsp" method="POST">
                        <!-- Name -->
                        <div class="mb-3">
                            <label class="form-label">Name</label>
                            <input type="text" class="form-control" name="name" required>
                        </div>

                        <!-- Email -->
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>

                        <!-- Password -->
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>

                        <!-- Role Selection -->
                        <div class="mb-3">
                            <label class="form-label">Role</label>
                            <select class="form-select" name="role" id="roleSelect" required>
                                <option value="Patient">Patient</option>
                                <option value="Doctor">Doctor</option>
                            </select>
                        </div>

                        <!-- Specialization (Only for Doctor) -->
                        <div class="mb-3" id="specializationField">
                            <label class="form-label">Specialization</label>
                            <input type="text" class="form-control" name="specialization" placeholder="e.g. Cardiologist">
                        </div>

                        <!-- Signup Button -->
                        <button type="submit" class="btn btn-success w-100">Sign Up</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="container mt-4">
        <h2 class="text-center text-primary mb-4">Registered Users</h2>

        <div class="row">
            <% 
                Connection con = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Hackathon", "root", "Vineet@098");
            %>
            <!-- 🔹 Doctors Table -->
<div class="col-md-6">
    <div class="card shadow">
        <div class="card-header bg-success text-white">
            <h5 class="mb-0">Doctors</h5>
        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <thead class="table-success">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Specialization</th>
                        <th>Action</th> <!-- Added Delete Column -->
                    </tr>
                </thead>
                <tbody>
                    <%
                        PreparedStatement pst = con.prepareStatement("SELECT id, name, email, specialization FROM users WHERE role = 'Doctor'");
                        ResultSet rs = pst.executeQuery();

                        while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("name") %></td>
                        <td><%= rs.getString("email") %></td>
                        <td><%= rs.getString("specialization") %></td>
                        <td>
                            <a href="deleteDoctor.jsp?id=<%= rs.getInt("id") %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this doctor?');">
                                Delete
                            </a>
                        </td>
                    </tr>
                    <%
                        }
                        rs.close();
                        pst.close();
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>

            <!-- 🔹 Patients Table -->
            <div class="col-md-6">
                <div class="card shadow">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0">Patients</h5>
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered">
                            <thead class="table-info">
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    PreparedStatement pst2 = con.prepareStatement("SELECT id, name, email FROM users WHERE role = 'Patient'");
                                    ResultSet rs2 = pst2.executeQuery();

                                    while (rs2.next()) {
                                %>
                                    <tr>
                                        <td><%= rs2.getInt("id") %></td>
                                        <td><%= rs2.getString("name") %></td>
                                        <td><%= rs2.getString("email") %></td>
                                    </tr>
                                <%
                                    }
                                    rs2.close();
                                    pst2.close();
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <%
                } catch (Exception e) {
                    out.println("<p class='text-danger text-center'>Error: " + e.getMessage() + "</p>");
                } finally {
                    if (con != null) try { con.close(); } catch (Exception ignore) {}
                }
            %>
        </div>
    </div>

    <!-- 🟢 Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        $(document).ready(function () {
        $("#doctorSelect, #appointmentDate").on("change", function () {
            var doctorEmail = $("#doctorSelect").val();
            var appointmentDate = $("#appointmentDate").val();
            
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

        document.getElementById("roleSelect").addEventListener("change", function () {
            var specializationField = document.getElementById("specializationField");
            specializationField.style.display = this.value === "Doctor" ? "block" : "none";
        });

        // Alert for Successful Appointment Booking
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get("appointment") === "success") {
            alert("Appointment booked successfully!");
        }
    </script>

</body>
</html>
