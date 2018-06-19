<%@page import="java.sql.DriverManager"%>  
<%@page import="java.sql.ResultSet"%>  
<%@page import="java.sql.Statement"%>  
<%@page import="java.sql.Connection"%>  
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	request.setCharacterEncoding("UTF-8");
	String eid = request.getParameter(application.getInitParameter("HTML_TAKE_EXAM_INPUT_EID"));
    Boolean usertype = (Boolean) session.getAttribute(application.getInitParameter("ATTR_IS_STUDENT"));
    if (usertype == false) {
        session.setAttribute(application.getInitParameter("HTML_PRE_EXAM_ALERT_TEACHER_CANT_TAKE_EXAM"), true);
        response.sendRedirect("pre_exam.jsp");
        return;
    }
    String sid = (String)session.getAttribute(application.getInitParameter("ATTR_USERID"));
    String sql = "select * from aexam where " + application.getInitParameter("DB_EID") + "=" + eid + " AND " + application.getInitParameter("DB_EPUBLISHED") + "= 1;";
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
        	session.setAttribute(application.getInitParameter("HTML_PRE_EXAM_ALERT_INVALID_EID"), true);
            response.sendRedirect("pre_exam.jsp"); 
            return; 
        } else {
            rs.close();
            sql = "select * from ase where " + application.getInitParameter("DB_SID") + "=" + sid + " AND " + application.getInitParameter("DB_EID") + "=" + eid;
            rs = st.executeQuery(sql);
            if (!rs.next()) {
                response.sendRedirect("do_exam.jsp?eid=" + eid + "&sid=" + sid);
                return;
            }
            
            session.setAttribute(application.getInitParameter("HTML_PRE_EXAM_ALERT_EXAM_ALREADY_TAKEN"), true);
            response.sendRedirect("pre_exam.jsp");
            return;
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