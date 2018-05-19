<%@page import="java.sql.DriverManager"%>  
<%@page import="java.sql.ResultSet"%>  
<%@page import="java.sql.Statement"%>  
<%@page import="java.sql.Connection"%>  
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    request.setCharacterEncoding("UTF-8");
    // exam infomation
    String eid = request.getParameter(application.getInitParameter("DB_EID"));
    String sid = request.getParameter(application.getInitParameter("DB_SID"));
    String examName = "";
    int examDuration = 0;
    int examScore = 0;
    float examAverageScore = 0;
    int examMaxScore = 0;
    // check user type
    String userid = (String)session.getAttribute(application.getInitParameter("ATTR_USERID"));
    Boolean isStudent = (Boolean)session.getAttribute(application.getInitParameter("ATTR_IS_STUDENT"));
    if (userid == null || isStudent == null){
        session.setAttribute(application.getInitParameter("HTML_SIGNIN_ALERT_SIGNIN_FIRST"), true);
        response.sendRedirect("signin.jsp");
        return;
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
    String getExamName = "select * from aexam where " + application.getInitParameter("DB_EID") + "= " + eid;
    String getExamAnalyze = "select * from get_exam_analyze where " + application.getInitParameter("DB_EID") + "= " + eid;
    String getStudentScore = "select * from ase where " + application.getInitParameter("DB_SID") + "=" + sid + " AND " + application.getInitParameter("DB_EID") + "=" + eid;
    try { 
        Class.forName("com.mysql.jdbc.Driver");  
        //数据库的地址，密码，用户名  
        conn = DriverManager.getConnection(url, user, pass);
        st = conn.createStatement();
        rs = st.executeQuery(getExamName);
        if (!rs.next()) {
            out.print("无效的考试ID！");
            return;
        } else {
            examName = rs.getString(application.getInitParameter("DB_ENAME"));
            examDuration = rs.getInt(application.getInitParameter("DB_EDURATION"));
        }
        rs.close();
        rs = st.executeQuery(getExamAnalyze);
        if (rs.next()) {
            examAverageScore = rs.getFloat(application.getInitParameter("DB_AVE_SCORE"));
            examMaxScore = rs.getInt(application.getInitParameter("DB_MAX_SCORE"));
        }
        rs.close();
        rs = st.executeQuery(getStudentScore);
        if (rs.next()) {
            examScore = rs.getInt(application.getInitParameter("DB_SCORE"));
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
<html lang="zh-CN">
    <head>
        <%@ include file="header.jsp" %>
        <%@ include file="script.jsp" %>
        <title>Axam-成绩统计</title>
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
                
                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
                    <div class="list-group">
                        <a class="list-group-item" href="javascript:void(0);">
                            <h3 class="panel-title">你的得分</h3>
                            <h1><%=examScore%></h1>
                        </a>
                    </div> 
                </div>
                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
                    <div class="list-group">
                        <a class="list-group-item" href="javascript:void(0);">
                            <h3 class="panel-title">最高分</h3>
                            <h1><%out.print(examMaxScore == 0 ? "--" : examMaxScore + "");%></h1>
                        </a>
                    </div> 
                </div>

                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
                    <div class="list-group">
                        <a class="list-group-item" href="javascript:void(0);">
                            <h3 class="panel-title">平均分</h3>
                            <h1><%out.print(examAverageScore == 0 ? "--" : examAverageScore + "");%></h1>
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
                    </div>                    
                </div>
            </div>

            <div class="row">
                <div class="list-group">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <a class="list-group-item" href="dashboard.jsp">
                            <h4 class="text-center"><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span> 返回</h4>
                        </a>
                    </div>
                </div>
            </div>
            <%
                String getQuestionList = "select * from get_exam_question_option_list where " + application.getInitParameter("DB_EID") + "=" + eid + " order by " + application.getInitParameter("DB_QNUMBER");
                String getAnswerSheet = "select * from get_exam_answer_sheet where " + application.getInitParameter("DB_EID") + "=" + eid + " order by " + application.getInitParameter("DB_QNUMBER");
                String getStudentAnswerSheet = "select * from get_student_answer_sheet where " + application.getInitParameter("DB_SID") + "=" + sid + " AND " + application.getInitParameter("DB_EID") + "=" + eid + " order by " + application.getInitParameter("DB_QNUMBER");
                String script = "<script>addQuestions_contrast(";
                int questionNum = 0;
                Statement answerSt = null; 
                ResultSet answerRS = null;
                Statement studentAnswerSt = null;
                ResultSet studentAnswerRS = null;
                try { 
                    Class.forName("com.mysql.jdbc.Driver");  
                    //数据库的地址，密码，用户名  
                    conn = DriverManager.getConnection(url, user, pass);
                    answerSt = conn.createStatement();
                    studentAnswerSt = conn.createStatement();
                    st = conn.createStatement();
                    rs = st.executeQuery(getQuestionList);
                    answerRS = answerSt.executeQuery(getAnswerSheet);
                    studentAnswerRS = studentAnswerSt.executeQuery(getStudentAnswerSheet);
                    studentAnswerRS.next();
                    while (rs.next()) {
                        if (questionNum != rs.getInt(application.getInitParameter("DB_QNUMBER"))){
                            answerRS.next();
                            if (questionNum != 0) {
                                script += ");</script>";
                                out.print(script);
                                script = "<script>addQuestions_contrast(";
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
                            script += "'" + answerRS.getString(application.getInitParameter("DB_OCONTENT")) + "'";
                            if (questionNum == studentAnswerRS.getInt(application.getInitParameter("DB_QNUMBER"))) {
                                script += ", ";
                                script += "'" + studentAnswerRS.getString(application.getInitParameter("DB_OCONTENT")) + "'";
                                studentAnswerRS.next();
                            } else {
                                script += ", ";
                                script += "null";
                            }
                            script += ", ";
                            script += "'" + rs.getString(application.getInitParameter("DB_OCONTENT")) + "'";
                        } else {
                            script += ", ";
                            script += "'" + rs.getString(application.getInitParameter("DB_OCONTENT")) + "'";
                        }
                    }
                    if (!script.equals("<script>addQuestions_contrast(") && questionNum != 0) {
                        script += ");</script>";
                        out.print(script);
                    }
                    questionNum++;
                } catch (Exception e) {  
                    out.print(e.getMessage());
                    out.print(e);
                } finally {  
                    try {
                        studentAnswerRS.close();
                        answerRS.close();  
                        rs.close();  
                    } catch (Exception e) {}  
                    try {  
                        st.close();
                        answerSt.close();
                        studentAnswerSt.close();
                    } catch (Exception e) {}  
                    try {  
                        conn.close();  
                    } catch (Exception e) {}  
                }
            %>  
        </div>    
    </body>
</html>