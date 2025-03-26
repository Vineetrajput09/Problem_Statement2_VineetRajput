<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generated Slip</title>
    <link rel="stylesheet" href="slip.css">
</head>
<body>
    <div class="slip-container">
        <h1>Generated Slip</h1>
        <table>
            <tr>
                <th>Disease</th>
                <th>Medicine</th>
                <th>treatment</th>
                <th>Note</th>
            </tr>
        <%
            String s1 = request.getParameter("sy1");
            String s2 = request.getParameter("sy2");
            String s3 = request.getParameter("sy3");

            String s4 = request.getParameter("name");
            String s5 = request.getParameter("age");

            String url = "jdbc:mysql://localhost:3306/Hackathon";
            String username = "root";
            String password = "Vineet@098";
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, username, password);
                String query = "SELECT * FROM diseases WHERE symtons_1 = ? or symtons_2 = ? or symtons_3 = ?";
                pstmt = conn.prepareStatement(query);
                pstmt.setString(1, s1);
                pstmt.setString(2, s2);
                pstmt.setString(3, s3);
                rs = pstmt.executeQuery();
                out.print("<p>Name : " + s4 + "</p>");
                out.print("Age : " +s5);
                while(rs.next()) {

            
    
                    String name = rs.getString("disease");
                    String value1 = rs.getString("medicine");
                    String value2 = rs.getString("treatement");
                    String value3 = rs.getString("notes");
                    
        %>
                    <tr>
                        <td><%= name %></td>
                        <td><%= value1 %></td>
                        <td><%= value2 %></td>
                        <td><%= value3 %></td>
                    </tr>
                   
            
        <%
            
            }
            } catch (Exception e) {
                out.print(e);
                e.printStackTrace();
        %>
                <p>Error fetching data from the database.</p>
        <%
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        %>
    </table>
       <button type="submit" value="submit" ><a href="fetchSymptoms.jsp">Back</a></button>
    </div>
</body>
</html>

