<%@page import="java.sql.DriverManager"%>  
<%@page import="java.sql.ResultSet"%>  
<%@page import="java.sql.Statement"%>  
<%@page import="java.sql.Connection"%>  
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    request.setCharacterEncoding("UTF-8");
    String eid = request.getParameter(application.getInitParameter("DB_EID"));
    String sid = request.getParameter(application.getInitParameter("DB_SID"));
    if (eid == null || sid == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String retRef = request.getHeader("Referer");
    if (!retRef.contains("pre_exam.jsp")) {
        response.sendRedirect("index.jsp");
        return;
    }

    String examName = "";
    int examDuration = 0;
    int examPeopleSum = 0;
    float examAverageScore = 0;
    int examMaxScore = 0;
    
    // 数据库链接  
    Connection conn = null;  
    // 向数据库发送sql语句  
    Statement st = null;  
    // 结果集  
    ResultSet rs = null;  
    String url = "jdbc:mysql://123.206.201.200:3306/Axam";  
    String user = "root";  
    String pass = "acLALDIQc3Qb";
    String getExamName = "select * from aexam where " + application.getInitParameter("DB_EID") + "= " + eid;
    String setExamStart = "insert into ase(" + application.getInitParameter("DB_SID") + ", " + application.getInitParameter("DB_EID") +") values (" + sid + ", " + eid + ");";
    try { 
        Class.forName("com.mysql.jdbc.Driver");  
        //数据库的地址，密码，用户名  
        conn = DriverManager.getConnection(url, user, pass);
        st = conn.createStatement();
        st.execute(setExamStart);
        rs = st.executeQuery(getExamName);
        if (!rs.next()) {
            out.print("无效的考试ID！");
            return;
        } else {
            examName = rs.getString(application.getInitParameter("DB_ENAME"));
            examDuration = rs.getInt(application.getInitParameter("DB_EDURATION"));
        }
    } catch (Exception e) {  
  		// out.print(e.getMessage());
    	// out.print(e);
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
<html lang="zh-CN">
    <head>
        <%@ include file="header.jsp" %>
        <%@ include file="script.jsp" %>
        <title>Axam-参加考试</title>
    </head>
    <body>
        <!-- 在这里增加网站内容 -->
        <div class="container" id="main-container">
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="page-header">
                        <h1 id="exam-title"><%=examName%>  
                            <small>
                                考试时长：<%out.print(examDuration == 0 ? "无限制" : examDuration + "分钟");%>
                            </small>
                        </h1>
                    </div>
                </div>
            </div>          
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="list-group">
                        <a class="list-group-item" href="javascript:void(0);">
                            <h3 class="panel-title">剩余时间</h3>
                            <h1 id="time-left"></h1>
                            <%out.print("<script>startTimer(" + examDuration + ");</script>");%>
                        </a>
                    </div> 
                </div>
            </div>           
            <div class="row" id="add-question">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="list-group">
                        <a class="list-group-item active" data-toggle="modal" href="#modal-add-choice-question" onclick="initOptions('add');" style="display: none">
                            <h4><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 添加题目</h4>
                        </a>
                        <a id="submit-exam" class="list-group-item active" href="javascript:void(0);">
                            <h4 class="text-center"><span class="glyphicon glyphicon-cloud-upload" aria-hidden="true"></span> 交卷</h4>
                        </a>
                    </div>                    
                </div>
            </div>

            <form id="form-make-choice" style="display: none">
                <input name="student_id" id="make-choice-sid" type="number" style="display: none">
                <%out.print("<script>changeInputValue('make-choice-sid', '" + sid + "');</script>");%>
                <input name="question_id" id="make-choice-qid" type="number" style="display: none">
                <input name="option_id" id="make-choice-oid" type="number" style="display: none">
            </form> 
        </div>
        <%
            String getQuestionList = "select * from get_exam_question_option_list where " + application.getInitParameter("DB_EID") + "=" + eid + " order by " + application.getInitParameter("DB_QNUMBER");
            String script = "<script>addQuestions_do(";
            String scriptDoChoice = "<script>setOptionsClickEvent(";
            int questionNum = 0;
            Statement stInsert = null;
            try { 
                Class.forName("com.mysql.jdbc.Driver");  
                //数据库的地址，密码，用户名  
                conn = DriverManager.getConnection(url, user, pass);
                st = conn.createStatement();
                stInsert = conn.createStatement();
                rs = st.executeQuery(getQuestionList);
                while (rs.next()) {
                    if (questionNum != rs.getInt(application.getInitParameter("DB_QNUMBER"))){
                        if (questionNum != 0) {
                            script += ");</script>";
                            out.print(script);
                            script = "<script>addQuestions_do(";

                            scriptDoChoice += ");</script>";
                            out.print(scriptDoChoice);
                            scriptDoChoice = "<script>setOptionsClickEvent(";
                        }
                        script += "'" + rs.getString(application.getInitParameter("DB_QID")) + "'";
                        script += ", ";
                        questionNum = rs.getInt(application.getInitParameter("DB_QNUMBER"));
                        script += questionNum;
                        script += ", ";
                        script += "'" + rs.getString(application.getInitParameter("DB_QSCORE")) + "'";
                        script += ", ";
                        script += "'" + rs.getString(application.getInitParameter("DB_QCONTENT")) + "'";
                        script += ", ";
                        script += "'" + rs.getString(application.getInitParameter("DB_OCONTENT")) + "'";

                        scriptDoChoice += "'" + rs.getString(application.getInitParameter("DB_QID")) + "'";;
                        scriptDoChoice += ", ";
                        scriptDoChoice += questionNum;
                        scriptDoChoice += ", ";
                        scriptDoChoice += "'" + rs.getString(application.getInitParameter("DB_OID")) + "'";

                        String insertRecord = "insert into asq(" + application.getInitParameter("DB_SID") + ", " + application.getInitParameter("DB_QID") + ")";
                        insertRecord += " values(" + sid + ", " + rs.getString(application.getInitParameter("DB_QID")) + ");";
                        stInsert.execute(insertRecord); 
                    } else {
                        script += ", ";
                        script += "'" + rs.getString(application.getInitParameter("DB_OCONTENT")) + "'";
                        scriptDoChoice += ", ";
                        scriptDoChoice += "'" + rs.getString(application.getInitParameter("DB_OID")) + "'";
                    }
                }
                if (!script.equals("<script>addQuestions_show(") && questionNum != 0) {
                    script += ");</script>";
                    out.print(script);
                    scriptDoChoice += ");</script>";
                    out.print(scriptDoChoice);
                }
                script = "<script>changeHref('submit-exam', '" + sid + "', '" + eid + "');</script>"; 
                out.print(script);
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
    </body>
</html>
