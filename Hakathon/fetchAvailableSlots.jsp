<%@ page import="java.sql.*, java.io.*" %>
<%
    String doctorEmail = request.getParameter("doctor_email");
    String appointmentDate = request.getParameter("appointment_date");

    if (doctorEmail != null && appointmentDate != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Hackathon", "root", "Vineet@098");

            // Define available time slots (e.g., 9:00 AM - 5:00 PM with 30-minute slots)
            String[] availableSlots = {
                "09:00:00", "09:30:00", "10:00:00", "10:30:00",
                "11:00:00", "11:30:00", "12:00:00", "12:30:00",
                "14:00:00", "14:30:00", "15:00:00", "15:30:00",
                "16:00:00", "16:30:00"
            };

            // Fetch booked slots from the database
            PreparedStatement pst = con.prepareStatement(
                "SELECT appointment_time FROM appointments WHERE doctor_email = ? AND appointment_date = ?");
            pst.setString(1, doctorEmail);
            pst.setString(2, appointmentDate);
            ResultSet rs = pst.executeQuery();

            // Store booked slots in a HashSet for quick lookup
            java.util.Set<String> bookedSlots = new java.util.HashSet<>();
            while (rs.next()) {
                bookedSlots.add(rs.getString("appointment_time"));
            }

            // Generate dropdown options with available slots
            for (String slot : availableSlots) {
                if (!bookedSlots.contains(slot)) {
%>
                    <option value="<%= slot %>"><%= slot.substring(0, 5) %></option>
<%
                }
            }

            rs.close();
            pst.close();
            con.close();
        } catch (Exception e) {
            out.println("<option disabled>Error fetching slots</option>");
        }
    } else {
        out.println("<option disabled>Invalid request</option>");
    }
%>
