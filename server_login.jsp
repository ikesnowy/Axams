<%@page import="java.sql.DriverManager"%>  
<%@page import="java.sql.ResultSet"%>  
<%@page import="java.sql.Statement"%>  
<%@page import="java.sql.Connection"%>  
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	request.setCharacterEncoding("UTF-8");
	String uemail = request.getParameter(application.getInitParameter("HTML_SIGNIN_INPUT_EMAIL"));
	String upass = request.getParameter(application.getInitParameter("HTML_SIGNIN_INPUT_PASSWORD"));
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
        Class.forName("com.mysql.jdbc.Driver");  
        //数据库的地址，密码，用户名  
        conn = DriverManager.getConnection(url, user, pass);
        st = conn.createStatement();
        rs = st.executeQuery(sql);
        
		if (!rs.next()){
        	session.setAttribute(application.getInitParameter("HTML_SIGNIN_ALERT_INVALID_PASS"), true);
            response.sendRedirect("signin.jsp");  
        } else {
			String username = rs.getString(application.getInitParameter("DB_USERNAME"));
            session.setAttribute(application.getInitParameter("ATTR_USERNAME"), username);
            response.sendRedirect("index.jsp");
        }
  
    } catch (Exception e) {  
  		out.print(e.getMessage());
    	out.print(e);
    } finally {  
        try {  
            rs.close();  
        } catch (Exception e) {}  
        try {  
            st.close();  
        } catch (Exception e) {}  
        try {  
            conn.close();  
        } catch (Exception e) {}  
    }

%>