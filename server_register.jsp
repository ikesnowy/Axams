<%@page import="java.sql.DriverManager"%>  
<%@page import="java.sql.ResultSet"%>  
<%@page import="java.sql.Statement"%>  
<%@page import="java.sql.Connection"%>  
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	request.setCharacterEncoding("UTF-8");
	String uemail = request.getParameter(application.getInitParameter("HTML_SIGNUP_INPUT_EMAIL"));
	String upass = request.getParameter(application.getInitParameter("HTML_SIGNUP_INPUT_PASSWORD"));
    String uname = request.getParameter(application.getInitParameter("HTML_SIGNUP_INPUT_USERNAME"));
    out.print(uemail);
    out.print(upass);
    out.print(uname);

    String sql = "insert into astudent("+ application.getInitParameter("DB_SUSERNAME");
    sql += ", " + application.getInitParameter("DB_SPASSWORD") + "";
    sql += ", " + application.getInitParameter("DB_SEMAIL") + ") ";
    sql += "values ('" + uname + "'";
    sql += ", '" + upass + "'";
    sql += ", '" + uemail + "')";

    String checkUserExist = "select * from astudent where " + application.getInitParameter("DB_EMAIL") + " = '" + uemail + "'";
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
        rs = st.executeQuery(checkUserExist);

		if (rs.next()){
        	session.setAttribute(application.getInitParameter("HTML_SIGNUP_ALERT_USER_ALREADY_EXIST"), true);
            response.sendRedirect("signup.jsp");  
        } 

        st.execute(sql);
        session.setAttribute(application.getInitParameter("HTML_SIGNIN_ALERT_USER_REGISTER_SUCCESSFUL"), true);
        response.sendRedirect("signin.jsp");
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