<%@page import="java.sql.DriverManager"%>  
<%@page import="java.sql.ResultSet"%>  
<%@page import="java.sql.Statement"%>  
<%@page import="java.sql.Connection"%>  
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	request.setCharacterEncoding("UTF-8");
    Long uid = System.currentTimeMillis();
	String uemail = request.getParameter(application.getInitParameter("HTML_SIGNUP_INPUT_EMAIL"));
	String upass = request.getParameter(application.getInitParameter("HTML_SIGNUP_INPUT_PASSWORD"));
    String uname = request.getParameter(application.getInitParameter("HTML_SIGNUP_INPUT_USERNAME"));
    String loginType = request.getParameter(application.getInitParameter("HTML_SIGNUP_RADIO_USERTYPE"));
    Boolean isStudent = loginType.equals(application.getInitParameter("HTML_SIGNUP_RADIO_VALUE_STUDENT"));

    String sql, checkUserExist;
    if (isStudent) {
        sql = "insert into astudent("+ application.getInitParameter("DB_SID");
        sql += ", " + application.getInitParameter("DB_SUSERNAME") + "";
        sql += ", " + application.getInitParameter("DB_SPASSWORD") + "";
        sql += ", " + application.getInitParameter("DB_SEMAIL") + ") ";
        sql += "values (" + uid + "";
        sql += ", '" + uname + "'";
        sql += ", '" + upass + "'";
        sql += ", '" + uemail + "')";
        checkUserExist = "select * from astudent where " + application.getInitParameter("DB_SEMAIL") + " = '" + uemail + "'";
    } else {
        sql = "insert into ateacher("+ application.getInitParameter("DB_TID");
        sql += ", " + application.getInitParameter("DB_TUSERNAME") + "";
        sql += ", " + application.getInitParameter("DB_TPASSWORD") + "";
        sql += ", " + application.getInitParameter("DB_TEMAIL") + ") ";
        sql += "values (" + uid + "";
        sql += ", '" + uname + "'";
        sql += ", '" + upass + "'";
        sql += ", '" + uemail + "')";
        checkUserExist = "select * from ateacher where " + application.getInitParameter("DB_TEMAIL") + " = '" + uemail + "'";
    }

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