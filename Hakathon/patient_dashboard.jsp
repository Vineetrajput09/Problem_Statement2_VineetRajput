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
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .navbar { font-size: 1.2rem; } /* Increase Navbar Text Size */
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
                    <li class="nav-item"><a class="nav-link fs-5" href="fetchSymptoms.jsp">Medicines</a></li>
                    <li class="nav-item"><a class="nav-link fs-5" href="#">About</a></li>
                </ul>
                <a href="logout.jsp" class="btn btn-danger fs-5">Logout</a>
            </div>
        </div>
    </nav>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get("appointment") === "success") {
            alert("Appointment booked successfully!");
        }
    </script>    
</body>
</html>