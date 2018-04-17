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
    <title>Axam-登录</title>
  </head>
  <body>
    <%@include file="navbar.jsp" %>
    <script>setNavbarActive('sign_in');</script>
    <div class="container"> 
        <div class="row row-centered">
            <div class="well col-xs-6 col-sm-6 col-md-6 col-lg-6 col-centered">
                <div id="error_invalid_pass" class="alert alert-danger" hidden="hidden">
                    <strong>登录失败！</strong> 用户名或密码错误
                </div>
                <div id="success_register_success" class="alert alert-success" hidden="hidden">
                    <strong>注册成功！</strong>
                </div>

                <form action="server_login.jsp" method="POST" role="form">
                    <legend>登录</legend>    
                    <div class="form-group" id="email-input">
                        <label for="">Email</label>
                        <input type="text" class="form-control" id="email" name="email" placeholder="输入电子邮件" onblur="loginValidation('email', 'email-input', 'email-input-success', 'email-input-failed', 'password', 'password-input', 'password-input-success', 'password-input-failed', 'login-button');">
                        <span id="email-input-success" class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true" style="display: none"></span>
                        <span id="email-input-failed" class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true" style="display: none"></span>
                    </div>
                    <div class="form-group" id="password-input">
                        <label for="">密码</label>
                        <input type="password" class="form-control" name="password" id="password" placeholder="输入密码" onblur="loginValidation('email', 'email-input', 'email-input-success', 'email-input-failed', 'password', 'password-input', 'password-input-success', 'password-input-failed', 'login-button');">
                        <span id="password-input-success" class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true" style="display: none"></span>
                        <span id="password-input-failed" class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true" style="display: none"></span>
                    </div>
                    
                    <a class="btn btn-link" href="#" role="button">忘记密码？</a>   
                    <button id="login-button" type="submit" class="btn btn-primary pull-right">登录</button>
                </form>
                <!-- 重置登录状态标志位，用户名或密码错误，用户不存在等 -->
                <%
                    String alert_invalid_pass = application.getInitParameter("HTML_SIGNIN_ALERT_INVALID_PASS");
                    String alert_register_successful = application.getInitParameter("HTML_SIGNIN_ALERT_USER_REGISTER_SUCCESSFUL");
                    Boolean isUsernameOrPasswordInvalid = (Boolean)session.getAttribute(alert_invalid_pass);
                    Boolean isUserRegisterSuccessful = (Boolean)session.getAttribute(alert_register_successful);
                    if (isUsernameOrPasswordInvalid == null)
                    {
                        session.setAttribute(alert_invalid_pass, false);
                        isUsernameOrPasswordInvalid = false;
                    }

                    if (isUserRegisterSuccessful == null)
                    {
                        session.setAttribute(alert_register_successful, false);
                        isUserRegisterSuccessful = false;
                    }
                        
                    if (isUsernameOrPasswordInvalid)
                    {
                        out.print("<script>displayElement('" + alert_invalid_pass +"'); </script>");
                        session.setAttribute(alert_invalid_pass, false);
                    }
                    if (isUserRegisterSuccessful)
                    {
                        out.print("<script>displayElement('" + alert_register_successful +"'); </script>");
                        session.setAttribute(alert_register_successful, false);
                    }
                %>      
            </div>
        </div>
    </div>   
  </body>
</html>