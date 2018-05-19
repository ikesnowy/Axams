<%@page import="java.sql.DriverManager"%>  
<%@page import="java.sql.ResultSet"%>  
<%@page import="java.sql.Statement"%>  
<%@page import="java.sql.Connection"%>  
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	request.setCharacterEncoding("UTF-8");
	String sid = request.getParameter(application.getInitParameter("DB_SID"));
	String eid = request.getParameter(application.getInitParameter("DB_EID"));
    String sql = "select * from get_student_choice_and_right_answer where ";
    sql += application.getInitParameter("DB_SID") + "=" + sid;
    sql += " AND ";
    sql += application.getInitParameter("DB_EID") + "=" + eid;
    int score = 0;

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
        
		while (rs.next()) {
            String oid = rs.getString(application.getInitParameter("DB_OID"));
            String answer = rs.getString(application.getInitParameter("DB_QANSWER"));
            out.print(oid);
            out.print(answer);
            if (oid == null)
                continue;
            if (oid.equals(answer)) {
                score += rs.getInt(application.getInitParameter("DB_QSCORE"));
            }
        }

        rs.close();
        sql = "update ase set " + application.getInitParameter("DB_SCORE") + "=" + score;
        sql += " where " + application.getInitParameter("DB_SID") + "=" + sid;
        sql += " and " + application.getInitParameter("DB_EID") + "=" + eid;
        st.execute(sql);
        response.sendRedirect("show_exam_result_student.jsp?" + application.getInitParameter("DB_EID") + "=" + eid + "&" + application.getInitParameter("DB_SID") + "=" + sid);
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