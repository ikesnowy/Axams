<%@page import="java.sql.DriverManager"%>  
<%@page import="java.sql.ResultSet"%>  
<%@page import="java.sql.Statement"%>  
<%@page import="java.sql.Connection"%>  
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    // exam infomation
    String eid = request.getParameter(application.getInitParameter("DB_EID"));
    String examName = "";
    int examDuration = 0;
    // check user type
    String userid = (String)session.getAttribute(application.getInitParameter("ATTR_USERID"));
    Boolean isStudent = (Boolean)session.getAttribute(application.getInitParameter("ATTR_IS_STUDENT"));
    if (userid == null || isStudent == null){
        session.setAttribute(application.getInitParameter("HTML_SIGNIN_ALERT_SIGNIN_FIRST"), true);
        response.sendRedirect("signin.jsp");
    }
    if (isStudent) {
        session.setAttribute(application.getInitParameter("HTML_SIGNIN_ALERT_NEED_AUTH"), true);
        response.sendRedirect("signin.jsp");
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
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <%@ include file="header.jsp" %>
        <%@ include file="script.jsp" %>
        <title>Axam-新增考试</title>
    </head>
    <body>
        <script>setNavbarActive('new_exam');</script>
        <!-- 在这里增加网站内容 -->
        <div class="container" id="main-container">            
            <div class="row">
                <div class="page-header">
                    <h1 id="exam-title" onmouseover="displayElement('modify_title');" onmouseout="hideElement('modify_title')"><%=examName%>  
                        <small>
                            考试时长：<%out.print(examDuration == 0 ? "无限制" : examDuration + "分钟");%>
                        </small>
                        <small>
                            <a id="modify_title" class="glyphicon glyphicon glyphicon-pencil" data-toggle="modal" href='#modal-modify-title'></a>                          
                        </small>
                    </h1>
                </div>
            </div>                     
            <div class="row" id="add-question">   
                <div class="list-group">
                    <a class="list-group-item" data-toggle="modal" href="#modal-add-choice-question">
                        <h4><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 添加题目</h4>
                    </a>
                </div>
            </div>
            <%
                String getQuestionList = "select * from get_exam_question_option_list where " + application.getInitParameter("DB_EID") + "=" + eid + " order by " + application.getInitParameter("DB_QNUMBER");
                String script = "<script>addQuestions(";
                try { 
                    Class.forName("com.mysql.jdbc.Driver");  
                    //数据库的地址，密码，用户名  
                    conn = DriverManager.getConnection(url, user, pass);
                    st = conn.createStatement();
                    rs = st.executeQuery(getQuestionList);
                    int questionNum = 0;
                    while (rs.next()) {
                        if (questionNum != rs.getInt(application.getInitParameter("DB_QNUMBER"))){
                            if (questionNum != 0) {
                                script += ");</script>";
                                out.print(script);
                                script = "<script>addQuestions(";
                            }
                            questionNum = rs.getInt(application.getInitParameter("DB_QNUMBER"));
                            script += questionNum;
                            script += ", ";
                            script += "'" + rs.getString(application.getInitParameter("DB_QSCORE")) + "'";
                            script += ", ";
                            script += "'" + rs.getString(application.getInitParameter("DB_QCONTENT")) + "'";
                            script += ", ";
                            script += "'" + rs.getString(application.getInitParameter("DB_OCONTENT")) + "'";
                        } else {
                            script += ", ";
                            script += "'" + rs.getString(application.getInitParameter("DB_OCONTENT")) + "'";
                        }
                    }
                    if (!script.equals("<script>addQuestions()")) {
                        script += ");</script>";
                        out.print(script);
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
        </div>

        <!-- 各类模态框 -->
        <!-- 修改考试名称 -->
        <div class="modal fade" id="modal-modify-title">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">修改考试信息</h4>
                    </div>
                    <div class="modal-body">                      
                        <form id="form_change_exam_info" action="" method="POST" role="form">
                            <div class="form-group" style="display: none">
                                <input type="text" name="exam_id" id="exam_id">
                                <%out.print("<script>changeInputValue('exam_id', '" + eid + "')</script>");%>
                            </div>   
                            <div class="form-group">
                                <label for="">输入新的考试名称</label>
                                <input type="text" class="form-control" name="exam_name" id="input-title" autocomplete="off" placeholder="考试名称……">
                                <%out.print("<script>changeInputValue('input-title', '" + examName + "')</script>");%>
                            </div>
                            <div class="form-group">
                                <label for="">输入考试时长（分钟）（0=无限制）</label>
                                <input type="number" class="form-control" name="exam_duration" id="input-duration" autocomplete="off" placeholder="考试时长……" >
                                <%out.print("<script>changeInputValue('input-duration', '" + examDuration + "')</script>");%>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="sendData('form_change_exam_info', 'server_change_exam_info.jsp');">确定</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 新增选择题 -->      
        <div class="modal fade" id="modal-add-choice-question">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">添加选择题</h4>
                    </div>
                    <div class="modal-body">
                        <form id="form_add_question" action="" method="POST" role="form">
                            <div class="form-group" style="display: none">
                                <input type="text" name="exam_id" id="exam_id">
                                <%out.print("<script>changeInputValue('exam_id', '" + eid + "')</script>");%>
                            </div>   
                            <div class="form-group">
                                <label for="">题目内容</label>
                                <input type="text" class="form-control" name="question-content" id="input-question-content" autocomplete="off" placeholder="题目内容……">
                            </div>
                            <div class="form-group">
                                <label for="">题目分值</label>
                                <input type="number" class="form-control" name="question-score" id="input-question-score" autocomplete="off" placeholder="题目分值……" value = "1">
                            </div>
                            <div class="form-group">
                                <label>选项列表</label>
                                <div class="input-group">
                                    <span class="input-group-addon">A.</span>
                                    <input type="text" class="form-control" name="option-1" id="input-option-1" autocomplete="off" placeholder="输入选项……">
                                    <span class="input-group-btn">
                                        <button class="btn btn-default" type="button"><span class="glyphicon glyphicon-minus"></span></button>
                                    </span>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">B.</span>
                                    <input type="text" class="form-control" name="option-2" id="input-option-2" autocomplete="off" placeholder="输入选项……">
                                    <span class="input-group-btn">
                                        <button class="btn btn-default" type="button"><span class="glyphicon glyphicon-minus"></span></button>
                                    </span>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">C.</span>
                                    <input type="text" class="form-control" name="option-3" id="input-option-3" autocomplete="off" placeholder="输入选项……">
                                    <span class="input-group-btn">
                                        <button class="btn btn-default" type="button"><span class="glyphicon glyphicon-minus"></span></button>
                                    </span>
                                </div>
                            </div>
                            <div class="form-group">
                                <a>+增加选项</a>
                            </div>
                            <div class="form-group">
                                <label>正确答案</label>
                                <select class="form-control">
                                    <option>A</option>
                                    <option>B</option>
                                    <option>C</option>
                                </select>
                            </div>
                        </form>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary">添加</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>