<%@ page import="java.sql.*, java.io.*" %>

<%
    String patientEmail = request.getParameter("patient_email");
    String doctorEmail = request.getParameter("doctor_email");
    String appointmentDate = request.getParameter("appointment_date");
    String appointmentTime = request.getParameter("appointment_time");

    if (patientEmail != null && doctorEmail != null && appointmentDate != null && appointmentTime != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Hackathon", "root", "Vineet@098");

            // Check if the slot is already booked
            PreparedStatement checkStmt = con.prepareStatement("SELECT * FROM appointments WHERE doctor_email = ? AND appointment_date = ? AND appointment_time = ?");
            checkStmt.setString(1, doctorEmail);
            checkStmt.setString(2, appointmentDate);
            checkStmt.setString(3, appointmentTime);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                out.println("<script>alert('Slot is already booked!'); window.history.back();</script>");
            } else {
                // Insert new appointment
                PreparedStatement pst = con.prepareStatement("INSERT INTO appointments (patient_email, doctor_email, appointment_date, appointment_time, status) VALUES (?, ?, ?, ?, 'Confirmed')");
                pst.setString(1, patientEmail);
                pst.setString(2, doctorEmail);
                pst.setString(3, appointmentDate);
                pst.setString(4, appointmentTime);

                int rowsInserted = pst.executeUpdate();

                if (rowsInserted > 0) {
                    out.println("<script>alert('Appointment booked successfully!');</script>");
                } else {
                    out.println("<script>alert('Failed to book appointment.'); window.history.back();</script>");
                }

                pst.close();
            }

            rs.close();
            checkStmt.close();
            con.close();
        } catch (Exception e) {
            out.println("<script>alert('Error: " + e.getMessage() + "'); window.history.back();</script>");
        }
    } else {
        out.println("<script>alert('All fields are required!'); window.history.back();</script>");
    }
%>
