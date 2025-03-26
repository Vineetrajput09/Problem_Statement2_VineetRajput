<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");

    if (id != null) {
        Connection con = null;
        PreparedStatement pstDeleteAppointments = null;
        PreparedStatement pstDeleteDoctor = null;

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Hackathon", "root", "Vineet@098");

            // Get doctor email
            PreparedStatement pstGetEmail = con.prepareStatement("SELECT email FROM users WHERE id = ?");
            pstGetEmail.setInt(1, Integer.parseInt(id));
            ResultSet rs = pstGetEmail.executeQuery();

            if (rs.next()) {
                String doctorEmail = rs.getString("email");

                // First, delete related appointments
                pstDeleteAppointments = con.prepareStatement("DELETE FROM appointments WHERE doctor_email = ?");
                pstDeleteAppointments.setString(1, doctorEmail);
                pstDeleteAppointments.executeUpdate();
            }
            
            // Now delete the doctor
            pstDeleteDoctor = con.prepareStatement("DELETE FROM users WHERE id = ?");
            pstDeleteDoctor.setInt(1, Integer.parseInt(id));
            int rowsAffected = pstDeleteDoctor.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("admin_dashboard.jsp"); // Redirect after successful deletion
            } else {
                out.println("Error: Doctor not found.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error deleting doctor: " + e.getMessage());
        } finally {
            if (pstDeleteAppointments != null) pstDeleteAppointments.close();
            if (pstDeleteDoctor != null) pstDeleteDoctor.close();
            if (con != null) con.close();
        }
    } else {
        out.println("Invalid doctor ID.");
    }
%>
