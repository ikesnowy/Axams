<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <%@ include file="header.jsp" %>
    <%@ include file="script.jsp" %>

    <!-- 在这里增加网站内容 -->
    <style> /*web background*/ 
    .bk{background-image: url("bg.jpg");}
    .container{ display:table; height:100%; } 
    .row{ display: table-cell; vertical-align: middle; } 
    .container#location{padding-top:150px;}
    /* centered columns styles */ 
    .row-centered { text-align:center; } 
    .col-centered { display:inline-block; float:none; text-align:left; margin-right:-4px; } 
    </style>
    <title>Axam-登录</title>
  </head>
  <body class="bk">
    <%@include file="navbar.jsp" %>
    <script>setNavbarActive('sign_in');</script>
    <div class="container" id="location"> 
        <div class="row row-centered">
            <div class="well col-xs-6 col-sm-6 col-md-6 col-lg-6 col-centered">
                <div id="error_invalid_pass" class="alert alert-danger" hidden="hidden">
                    <strong>登录失败！</strong> 用户名或密码错误
                </div>
                <div id="success_register_success" class="alert alert-success" hidden="hidden">
                    <strong>注册成功！</strong>
                </div>
                <div id="info_need_login" class="alert alert-info" hidden="hidden">
                    <strong>请先登录！</strong>
                </div>
                <div id="info_need_auth" class="alert alert-danger" hidden="hidden">
                    <strong>只有教师账户可以修改考试信息！</strong>
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
                    <button id="login-button" type="submit" class="btn btn-primary pull-right">登录</button>
                </form>
                <!-- 重置登录状态标志位，用户名或密码错误，用户不存在等 -->
                <%
                    String alert_invalid_pass = application.getInitParameter("HTML_SIGNIN_ALERT_INVALID_PASS");
                    String alert_register_successful = application.getInitParameter("HTML_SIGNIN_ALERT_USER_REGISTER_SUCCESSFUL");
                    String alert_need_login_first = application.getInitParameter("HTML_SIGNIN_ALERT_SIGNIN_FIRST");
                    String alert_need_auth = application.getInitParameter("HTML_SIGNIN_ALERT_NEED_AUTH");
                    Boolean isUsernameOrPasswordInvalid = (Boolean)session.getAttribute(alert_invalid_pass);
                    Boolean isUserRegisterSuccessful = (Boolean)session.getAttribute(alert_register_successful);
                    Boolean isSigninNeeded = (Boolean)session.getAttribute(alert_need_login_first);
                    Boolean isAuthNeeded = (Boolean)session.getAttribute(alert_need_auth);
                    if (isUsernameOrPasswordInvalid == null) {
                        session.setAttribute(alert_invalid_pass, false);
                        isUsernameOrPasswordInvalid = false;
                    }

                    if (isUserRegisterSuccessful == null) {
                        session.setAttribute(alert_register_successful, false);
                        isUserRegisterSuccessful = false;
                    }

                    if (isSigninNeeded == null) {
                        session.setAttribute(alert_need_login_first, false);
                        isSigninNeeded = false;
                    }

                    if (isAuthNeeded == null) {
                        session.setAttribute(alert_need_auth, false);
                        isAuthNeeded = false;
                    }
                        
                    if (isUsernameOrPasswordInvalid) {
                        out.print("<script>displayElement('" + alert_invalid_pass +"'); </script>");
                        session.setAttribute(alert_invalid_pass, false);
                    }
                    if (isUserRegisterSuccessful) {
                        out.print("<script>displayElement('" + alert_register_successful +"'); </script>");
                        session.setAttribute(alert_register_successful, false);
                    }
                    if (isSigninNeeded) {
                        out.print("<script>displayElement('" + alert_need_login_first +"'); </script>");
                        session.setAttribute(alert_need_login_first, false);
                    }
                    if (isAuthNeeded) {
                        out.print("<script>displayElement('" + alert_need_auth +"'); </script>");
                        session.setAttribute(alert_need_auth, false);
                    }
                %>      
            </div>
        </div>
    </div>   
  </body>
</html>