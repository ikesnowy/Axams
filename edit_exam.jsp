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
    String examName = "";
    int examDuration = 0;
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
<html lang="zh-CN">
    <head>
        <%@ include file="header.jsp" %>
        <%@ include file="script.jsp" %>
        <title>Axam-编辑考试</title>
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
                            <a id="modify_title" class="glyphicon glyphicon-pencil" style="display: none" data-toggle="modal" href='#modal-modify-title'></a>                          
                        </small>
                    </h1>
                </div>
            </div>                     
            <div class="row" id="add-question">   
                <div class="list-group">
                    <a class="list-group-item" data-toggle="modal" href="#modal-add-choice-question" onclick="initOptions('add');">
                        <h4><span class="glyphicon glyphicon-plus" aria-hidden="true"></span> 添加题目</h4>
                    </a>
                </div>
            </div>
            <%
                String getQuestionList = "select * from get_exam_question_option_list where " + application.getInitParameter("DB_EID") + "=" + eid + " order by " + application.getInitParameter("DB_QNUMBER");
                String getAnswerSheet = "select * from get_exam_answer_sheet where " + application.getInitParameter("DB_EID") + "=" + eid + " order by " + application.getInitParameter("DB_QNUMBER");
                String script = "<script>addQuestions(";
                int questionNum = 0;
                Statement answerSt = null; 
                ResultSet answerRS = null;
                try { 
                    Class.forName("com.mysql.jdbc.Driver");  
                    //数据库的地址，密码，用户名  
                    conn = DriverManager.getConnection(url, user, pass);
                    answerSt = conn.createStatement();
                    st = conn.createStatement();
                    rs = st.executeQuery(getQuestionList);
                    answerRS = answerSt.executeQuery(getAnswerSheet);
                    while (rs.next()) {
                        if (questionNum != rs.getInt(application.getInitParameter("DB_QNUMBER"))){
                            answerRS.next();
                            if (questionNum != 0) {
                                script += ");</script>";
                                out.print(script);
                                script = "<script>addQuestions(";
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
                            script += ", ";
                            script += "'" + rs.getString(application.getInitParameter("DB_OCONTENT")) + "'";
                        } else {
                            script += ", ";
                            script += "'" + rs.getString(application.getInitParameter("DB_OCONTENT")) + "'";
                        }
                    }
                    if (!script.equals("<script>addQuestions()") && questionNum != 0) {
                        script += ");</script>";
                        out.print(script);
                    }
                    questionNum++;
                } catch (Exception e) {  
                    out.print(e.getMessage());
                    out.print(e);
                } finally {  
                    try {
                        answerRS.close();  
                        rs.close();  
                    } catch (Exception e) {}  
                    try {  
                        st.close();
                        answerSt.close();
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
                            <div class="form-group" id="div-title">
                                <label for="">考试名称</label>
                                <input type="text" class="form-control" name="exam_name" id="input-title" autocomplete="off" placeholder="考试名称……">
                                <%out.print("<script>changeInputValue('input-title', '" + examName + "')</script>");%>
                            </div>
                            <div class="form-group" id="div-duration">
                                <label for="">考试时长（分钟）（0=无限制）</label>
                                <input type="number" class="form-control" name="exam_duration" id="input-duration" autocomplete="off" placeholder="考试时长……" >
                                <%out.print("<script>changeInputValue('input-duration', '" + examDuration + "')</script>");%>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary" onclick="submitAlterExamForm();">确定</button>
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
                                <input type="text" name="exam_id" id="exam_id_add_question" value="0">
                                <%out.print("<script>changeInputValue('exam_id_add_question', '" + eid + "')</script>");%>
                            </div>
                            <div class="form-group" style="display: none">
                                <input type="number" name="question_number" id="question_number_add_question" value="0">
                                <%out.print("<script>changeInputValue('question_number_add_question', '" + questionNum + "')</script>");%>
                            </div> 
                            <div class="form-group" style="display: none">
                                <input type="number" name="option_sum" id="add-option_sum" value="0">
                            </div>   
                            <div class="form-group" id="add-div-question-content">
                                <label for="">题目内容</label>
                                <input type="text" class="form-control" name="question-content" id="add-input-question-content" autocomplete="off" placeholder="题目内容……">
                            </div>
                            <div class="form-group" id="add-div-question-score">
                                <label for="">题目分值</label>
                                <input type="number" class="form-control" name="question-score" id="add-input-question-score" autocomplete="off" placeholder="题目分值……" value = "1">
                            </div>
                            <div class="form-group">
                                <label>选项列表</label>
                            </div>
                            
                            <div class="form-group" id="add-add-options">
                                <a class="form-control-static" onclick="addOptions('add');">+增加选项</a>
                            </div>
                            <div class="form-group">
                                <label>正确答案</label>
                                <select class="form-control" id="add-select-answer" name="right-answer">
                                </select>
                            </div>
                            <script>addOptions('add');addOptions('add');</script>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary" onclick="submitAddQuestionForm();">添加</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 修改选择题 -->
        <div class="modal fade" id="modal-modify-choice-question">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">修改选择题</h4>
                    </div>
                    <div class="modal-body">
                        <form id="form_modify_question" action="" method="POST" role="form">
                            <div class="form-group" style="display: none">
                                <input type="text" name="exam_id" id="exam_id_modify_question" value="0">
                                <%out.print("<script>changeInputValue('exam_id_modify_question', '" + eid + "')</script>");%>
                            </div>
                            <div class="form-group" style="display: none">
                                <input type="number" name="question_id" id="modify-question_id" value="0">
                            </div>
                            <div class="form-group" style="display: none">
                                <input type="number" name="option_sum" id="modify-option_sum" value="0">
                            </div>   
                            <div class="form-group" id="modify-div-question-content">
                                <label for="">题目内容</label>
                                <input type="text" class="form-control" name="question-content" id="modify-input-question-content" autocomplete="off" placeholder="题目内容……">
                            </div>
                            <div class="form-group" id="modify-div-question-score">
                                <label for="">题目分值</label>
                                <input type="number" class="form-control" name="question-score" id="modify-input-question-score" autocomplete="off" placeholder="题目分值……" value = "1">
                            </div>
                            <div class="form-group">
                                <label>选项列表</label>
                            </div>
                            
                            <div class="form-group" id="modify-add-options">
                                <a class="form-control-static" onclick="addOptions('modify');">+增加选项</a>
                            </div>
                            <div class="form-group">
                                <label>正确答案</label>
                                <select class="form-control" id="modify-select-answer" name="right-answer">
                                </select>
                            </div>
                            <script>addOptions('modify');addOptions('modify');</script>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary" onclick="submitModifyQuestionForm();">修改</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 删除选择题 -->
        <div class="modal fade" id="modal-delete-choice-question">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">删除确认</h4>
                    </div>
                    <div class="modal-body">
                        <p>确认删除这个问题吗？<strong>该操作不可恢复</strong></p>
                        <form id="form_delete_question" action="" method="POST" role="form">
                            <div class="form-group" style="display: none">
                                <input type="text" name="exam_id" id="exam_id_delete_question" value="0">
                                <%out.print("<script>changeInputValue('exam_id_delete_question', '" + eid + "')</script>");%>
                            </div>
                            <div class="form-group" style="display: none">
                                <input type="number" name="question_id" id="delete-question_id" value="0">
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-danger">删除</button>
                    </div>
                </div>
            </div>
        </div>
        
    </body>
</html>