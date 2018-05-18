<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <%@ include file="header.jsp" %>
    <%@ include file="script.jsp" %>

    <!-- 在这里增加网站内容 -->
    <style> /*web background*/ 
    .container{ display:table; height:100%; } 
    .row{ display: table-cell; vertical-align: middle; } 
    /* centered columns styles */ 
    .row-centered { text-align:center; } 
    .col-centered { display:inline-block; float:none; text-align:left; margin-right:-4px; } 
    </style>
    <title>Axam-参加考试</title>
  </head>
  <body>
    <%@include file="navbar.jsp" %>
    <%@include file="login_check.jsp" %>
    <script>setNavbarActive('take_exam');</script>
    <div class="container"> 
        <div class="row row-centered">
            <div class="well col-xs-6 col-sm-6 col-md-6 col-lg-6 col-centered">
                <div id="error_invalid_eid" class="alert alert-danger" hidden="hidden">
                    <strong>无效的考试 ID！</strong>
                </div>
                <div id="error_already_take_exam" class="alert alert-danger" hidden="hidden">
                    <strong>你已经参加过这项考试了！</strong>
                </div>
                <form action="server_check_exam.jsp" method="POST" role="form">
                    <legend>输入考试 ID</legend>    
                    <div class="form-group" id="eid-input">
                        <label for="">考试 ID</label>
                        <input type="text" class="form-control" id="eid" name="eid" placeholder="输入考试 ID">
                    </div>
                                                               
                    <button id="login-button" type="submit" class="btn btn-primary pull-right">查询</button>
                </form>
                <!-- 重置查询状态标志位 -->
                <%
                    String alert_invalid_eid = application.getInitParameter("HTML_PRE_EXAM_ALERT_INVALID_EID");
                    String alert_already_take_exam = application.getInitParameter("HTML_PRE_EXAM_ALERT_EXAM_ALREADY_TAKEN");
                    Boolean isEidInvalid = (Boolean)session.getAttribute(alert_invalid_eid);
                    Boolean isExamAlreadyTaken = (Boolean)session.getAttribute(alert_already_take_exam);
                    if (isEidInvalid == null) {
                        session.setAttribute(alert_invalid_eid, false);
                        isEidInvalid = false;
                    }

                    if (isExamAlreadyTaken == null) {
                        session.setAttribute(alert_already_take_exam, false);
                        isExamAlreadyTaken = false;
                    }
                        
                    if (isEidInvalid) {
                        out.print("<script>displayElement('" + alert_invalid_eid +"'); </script>");
                        session.setAttribute(alert_invalid_eid, false);
                    }
                    if (isExamAlreadyTaken) {
                        out.print("<script>displayElement('" + alert_already_take_exam +"'); </script>");
                        session.setAttribute(alert_already_take_exam, false);
                    }
                %>      
            </div>
        </div>
    </div>   
  </body>
</html>