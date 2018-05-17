<%@page import="java.sql.DriverManager"%>  
<%@page import="java.sql.ResultSet"%>  
<%@page import="java.sql.Statement"%>  
<%@page import="java.sql.Connection"%>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.FileUploadException" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");
    String eid = "";  // 考试 id
    DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
    ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
    try {
        List list = servletFileUpload.parseRequest(request);
        Iterator iterator = list.iterator();
        while (iterator.hasNext()) {
            FileItem item = (FileItem)iterator.next();
            if (item.isFormField()) { // judge if it is not the file field
                String name = item.getFieldName(); // get the form's child name
                if (name.equals(application.getInitParameter("HTML_EDIT_EXAM_INPUT_EXAM_ID"))) {
                    eid = item.getString("utf-8");
                }
            }
        }
    } catch (FileUploadException e) {
        e.printStackTrace();
    } catch (Exception e) {
        e.printStackTrace();
    }

    // 数据库链接  
    Connection conn = null;  
    // 向数据库发送sql语句  
    Statement st = null;  
    String deleteTE = "delete from ate where " + application.getInitParameter("DB_EID") + "=" + eid;
    String deleteSE = "delete from ase where " + application.getInitParameter("DB_EID") + "=" + eid;
    String url = "jdbc:mysql://123.206.201.200:3306/Axam";  
    String user = "root";  
    String pass = "acLALDIQc3Qb";
    try { 
        Class.forName("com.mysql.jdbc.Driver");  
        //数据库的地址，密码，用户名  
        conn = DriverManager.getConnection(url, user, pass);
        st = conn.createStatement();
        st.execute(deleteTE);
        st.execute(deleteSE);
    } catch (Exception e) {  
  		out.print(e.getMessage());
    	out.print(e);
    } finally {   
        try {  
            st.close();  
        } catch (Exception e) {}  
        try {  
            conn.close();  
        } catch (Exception e) {}  
    }
%>