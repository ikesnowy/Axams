<%@page import="java.sql.DriverManager"%>  
<%@page import="java.sql.ResultSet"%>  
<%@page import="java.sql.Statement"%>  
<%@page import="java.sql.Connection"%>  
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");
    // check user type
    String userid = (String)session.getAttribute(application.getInitParameter("ATTR_USERID"));
    Boolean isStudent = (Boolean)session.getAttribute(application.getInitParameter("ATTR_IS_STUDENT"));
    if (userid == null || isStudent == null){
        session.setAttribute(application.getInitParameter("HTML_SIGNIN_ALERT_SIGNIN_FIRST"), true);
        response.sendRedirect("signin.jsp");
        return;
    }
    if (isStudent) {
        session.setAttribute(application.getInitParameter("HTML_SIGNIN_ALERT_NEED_AUTH"), true);
        response.sendRedirect("signin.jsp");
        return;
    }

    String sql = "insert into aexam("+ application.getInitParameter("DB_ENAME") + ")";
    sql += " values ('输入考试名称')";

    String getEid = "select MAX(" + application.getInitParameter("DB_EID") +") from aexam";
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
        rs = st.executeQuery(getEid);
        rs.next();
        String eid = rs.getString("MAX(" + application.getInitParameter("DB_EID") + ")");
		sql = "insert into ate values ('" + userid + "', '" + eid + "')";
        st.execute(sql);
        String editURL = "edit_exam.jsp?" + application.getInitParameter("DB_EID") + "=" + eid;
        response.sendRedirect(editURL);
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