<%@page import="java.sql.DriverManager"%>  
<%@page import="java.sql.ResultSet"%>  
<%@page import="java.sql.Statement"%>  
<%@page import="java.sql.Connection"%>  
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%  
	request.setCharacterEncoding("UTF-8");
	String uemail = request.getParameter("email");
	String upass = request.getParameter("password");
    out.print(uemail);
    out.print(upass);
    String sql = "SELECT * FROM astudent WHERE semail = '" 
			+ uemail + "' AND spassword = '" + upass + "'";
    // 数据库链接  
    Connection conn = null;  
    // 向数据库发送sql语句  
    Statement st = null;  
    // 结果集  
    ResultSet rs = null;  
    String url = "jdbc:mysql://123.206.201.200:3306/Axam";  
    String user = "root";  
    String pass = "acLALDIQc3Qb";
    try {
        out.print("Driver start");  
        Class.forName("com.mysql.jdbc.Driver");  
        //数据库的地址，密码，用户名  
        out.print("start conn");
        conn = DriverManager.getConnection(url, user, pass);
        out.print("Connection successful");
        st = conn.createStatement();
        rs = st.executeQuery(sql);
        

		if (!rs.next()){
        	out.print("no user");
		} else {
			out.print("hello!");
		}
  
    } catch (Exception e) {  
  		out.print(e.getMessage());
    	out.print(e);
    } finally {  
        try {  
            rs.close();  
        } catch (Exception e) {  
        }  
        try {  
            st.close();  
        } catch (Exception e) {  
        }  
        try {  
            conn.close();  
        } catch (Exception e) {  
        }  
    }  
%>