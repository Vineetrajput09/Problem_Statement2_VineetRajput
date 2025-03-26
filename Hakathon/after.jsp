<%@ page import = "java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <%

String Disease= request.getParameter("name");
String symtom1 = request.getParameter("symtom1");
String symtom2 = request.getParameter("symtom2");
String symtom3 = request.getParameter("symtom3");
String medicine = request.getParameter("medicine");
String treatment = request.getParameter("treatment");
String note = request.getParameter("note");

 try {   
         
     Class.forName("com.mysql.cj.jdbc.Driver");
     Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Hackathon", "root", "Vineet@098");

     PreparedStatement pst = con.prepareStatement("insert into diseases(disease ,symtons_1,symtons_2,symtons_3,medicine ,treatement, notes) values(?,?,?,?,?,?,?)");
     pst.setString(1, Disease);
     pst.setString(2, symtom1);
     pst.setString(3, symtom2);
     pst.setString(4, symtom3);
     pst.setString(5, medicine);
     pst.setString(6, treatment);
     pst.setString(7, note);
     int result = pst.executeUpdate();

    if(result > 0)
    {
     out.print("seccessfully");
     response.sendRedirect("diseases.jsp");
    } else {
     out.print("unseccussfully");
    }
 
 } catch (ClassNotFoundException e) {
     out.println("Driver problem");
 } catch (SQLException e) {
     out.println("Empid already exits " + e);
 }

 
%>
</body>
</html>