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

    if(uname.length() >= 10 || uname.length() == 0 )
    {
        session.setAttribute(application.getInitParameter("HTML_SIGNIN_ALERT_INVALID_USER"), true);
        response.sendRedirect("signup.jsp"); 
    }
    if(upass.length() < 6)
    {
        session.setAttribute(application.getInitParameter("HTML_SIGNIN_ALERT_INVALID_PASS"), true);
        response.sendRedirect("signup.jsp"); 
    }

    out.print(uemail);
    out.print(upass);
    out.print(uname);
   //String sql = "SELECT * FROM astudent WHERE semail = '" 
			//+ uemail + "' AND spassword = '" + upass + "'";

    String sql = "insert into astudent("+ application.getInitParameter("DB_USERNAME");
    sql += ", " + application.getInitParameter("DB_PASSWORD") + "";
    sql += ", " + application.getInitParameter("DB_EMAIL") + ") ";
    sql += "values ('" + uname + "'";
    sql += ", '" + upass + "'";
    sql += ", '" + uemail + "')";
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
        st.execute(sql);
        
		/*if (!rs.next()){
        	session.setAttribute(application.getInitParameter("HTML_SIGNIN_ALERT_INVALID_PASS"), true);
            response.sendRedirect("signin.jsp");  
        } else {
			String username = rs.getString(application.getInitParameter("DB_USERNAME"));
            session.setAttribute(application.getInitParameter("ATTR_USERNAME"), username);
            response.sendRedirect("index.jsp");
        }*/
  
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