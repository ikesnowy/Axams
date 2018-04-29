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
    <title>Axam-注册</title>
  </head>
  <body>
    <%@include file="navbar.jsp" %>
    <script>setNavbarActive('sign_up');</script>
    <div class="container"> 
        <div class="row row-centered">
            <div class="well col-xs-6 col-sm-6 col-md-6 col-lg-6 col-centered">
          
                <div id="error_user_already_exist" class="alert alert-danger" hidden="hidden">
                    <strong>注册失败！</strong> 该 Email 已经被注册，是否需要<a href="signin.jsp">登录</a>？
                </div>
                <form action="server_register.jsp" method="POST" role="form">
                    <legend>注册</legend>    

                    <div id="username-div" class="form-group">
                        <label for="">用户名</label>
                        <input id="username-input" type="text" class="form-control" name="username" id="username" placeholder="输入用户名" onblur="registerValidation('username-input', 'username-div', 'username-input-success', 'username-input-failed', 'email-input', 'email-div', 'email-input-success', 'email-input-failed', 'password-input', 'password-div', 'password-input-success', 'password-input-failed', 'submit-button')">
                        <span id="username-input-success" class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true" style="display: none"></span>
                        <span id="username-input-failed" class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true" style="display: none"></span>
                        <span class="help-block">用户名最多不能超过 30 字节</span>
                    </div>
                    <div id="email-div" class="form-group">
                        <label for="">Email</label>
                        <input id="email-input" type="text" class="form-control" id="email" name="email" placeholder="输入电子邮件" onblur="registerValidation('username-input', 'username-div', 'username-input-success', 'username-input-failed', 'email-input', 'email-div', 'email-input-success', 'email-input-failed', 'password-input', 'password-div', 'password-input-success', 'password-input-failed', 'submit-button')">
                        <span id="email-input-success" class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true" style="display: none"></span>
                        <span id="email-input-failed" class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true" style="display: none"></span>
                        <span class="help-block">Email 不能超过 30 字节</span>
                    </div>
                    <div id="password-div" class="form-group">
                        <label for="">密码</label>
                        <input type="password" class="form-control" name="password" id="password-input" placeholder="输入密码" onblur="registerValidation('username-input', 'username-div', 'username-input-success', 'username-input-failed', 'email-input', 'email-div', 'email-input-success', 'email-input-failed', 'password-input', 'password-div', 'password-input-success', 'password-input-failed', 'submit-button')">
                        <span id="password-input-success" class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true" style="display: none"></span>
                        <span id="password-input-failed" class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true" style="display: none"></span>
                        <span class="help-block">不少于 6 位的数字和字母组合</span>
                    </div>
                    <div class="radio-inline">
                        <label>
                            <input type="radio" name="usertype" value="student" checked="checked">
                            学生
                        </label>
                    </div>
                    <div class="radio-inline">
                        <label>
                            <input type="radio" name="usertype" value="teacher">
                            教师
                        </label>
                    </div> 
                    <button id="submit-button" type="submit" class="btn btn-primary pull-right">注册</button>
                </form>
                <!-- 重置登录状态标志位，用户名或密码错误，用户不存在等 -->
                <%
                    String alert_user_already_exist = application.getInitParameter("HTML_SIGNUP_ALERT_USER_ALREADY_EXIST");
                    Boolean isUserAlreadyExist = (Boolean)session.getAttribute(alert_user_already_exist);

                    if (isUserAlreadyExist == null)
                    {
                        session.setAttribute(alert_user_already_exist, false);
                        isUserAlreadyExist = false;
                    }
                        
                    if (isUserAlreadyExist)
                    {
                        out.print("<script>displayElement('" + alert_user_already_exist +"'); </script>");
                        session.setAttribute(alert_user_already_exist, false);
                    }
                %>      
            </div>
        </div>
    </div>   
  </body>
</html>