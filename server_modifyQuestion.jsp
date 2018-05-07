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
    String qid = "";  // 问题 id
    String title = "";// 问题内容
    String score = "";// 问题分值
    String index = ""; //问题编号
    String[] options = new String[8];
    long[] optionsID = new long[8];
    int options_size = 0;
    int rightAnswer = 0;
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
                }  else if (name.equals(application.getInitParameter("HTML_EDIT_EXAM_INPUT_QUESTION_TITLE"))) {
                    title = item.getString("utf-8");
                } else if (name.equals(application.getInitParameter("HTML_EDIT_EXAM_INPUT_QUESTION_SCORE"))) {
                    score = item.getString("utf-8");
                } else if (name.equals(application.getInitParameter("HTML_EDIT_EXAM_INPUT_RIGHT_ANSWER"))) {
                    rightAnswer = Integer.parseInt(item.getString("utf-8"));
                    rightAnswer--;
                } else if (name.equals(application.getInitParameter("HTML_EDIT_EXAM_INPUT_OPTION_NUM"))) {
                    options_size = Integer.parseInt(item.getString("utf-8"));
                } else if (name.startsWith(application.getInitParameter("HTML_EDIT_EXAM_INPUT_OPTION_PREFIX"))) {
                    int qnumber = Integer.parseInt(name.substring(6));
                    options[qnumber - 1] = item.getString("utf-8");
                } else if (name.equals(application.getInitParameter("HTML_EDIT_EXAM_INPUT_QUESTION_INDEX"))) {
                	index = item.getString("utf-8");
                } else if (name.equals(application.getInitParameter("HTML_EDIT_EXAM_INPUT_QUESTION_ID"))) {
                    qid = item.getString("utf-8");
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
    // 结果集  
    ResultSet rsMaxOid = null;
    ResultSet rsMaxQid = null;  
    String url = "jdbc:mysql://123.206.201.200:3306/Axam";  
    String user = "root";  
    String pass = "acLALDIQc3Qb";
    try { 
        Class.forName("com.mysql.jdbc.Driver");  
        //数据库的地址，密码，用户名  
        conn = DriverManager.getConnection(url, user, pass);
        st = conn.createStatement();

        String deleteOption = "delete from aqo where " + application.getInitParameter("DB_QID") + "=" + qid;
        st.execute(deleteOption);
        String addOption = "";
        for (int i = 0; i < options_size; i++) {
            optionsID[i] = System.currentTimeMillis();
            addOption = "insert into aoption (";
            addOption += application.getInitParameter("DB_OID");
            addOption += ", " + application.getInitParameter("DB_OCONTENT") + ") ";
            addOption += "values ( "+ optionsID[i] + ", '";
            addOption += options[i] + "')";
            out.print(addOption + " ");
            st.execute(addOption);
        }
        String updateQuestion = "update aquestion set ";
        updateQuestion += application.getInitParameter("DB_QCONTENT") + "='" + title + "'";
        updateQuestion += ", ";
        updateQuestion += application.getInitParameter("DB_QANSWER") + "=" + optionsID[rightAnswer];
        updateQuestion += ", ";
        updateQuestion += application.getInitParameter("DB_QSCORE") + "=" + score;
        updateQuestion += " where " + application.getInitParameter("DB_QID") + "=" + qid;
        st.execute(updateQuestion);

        for (int i = 0; i < options_size; i++) {
            String addQO = "insert into aqo (" + application.getInitParameter("DB_QID");
            addQO += ", " + application.getInitParameter("DB_OID") + ") ";
            addQO += "values (" + qid + ", " + optionsID[i] + ");";
            st.execute(addQO);
        }
    } catch (Exception e) {  
  		out.print(e.getMessage());
    	out.print(e);
    } finally {  
        try {  
            rsMaxOid.close();
            rsMaxQid.close();  
        } catch (Exception e) {}  
        try {  
            st.close();  
        } catch (Exception e) {}  
        try {  
            conn.close();  
        } catch (Exception e) {}  
    }
%>