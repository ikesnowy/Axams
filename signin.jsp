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
                <form action="server_login.jsp" method="POST" role="form">
                    <legend>登录</legend>    
                    <div class="form-group">
                        <label for="">Email</label>
                        <input type="text" class="form-control" id="email" name="email" placeholder="输入电子邮件">
                    </div>
                    <div class="form-group">
                        <label for="">密码</label>
                        <input type="password" class="form-control" name="password" id="password" placeholder="输入密码">
                    </div>
                    
                    <a class="btn btn-link" href="#" role="button">忘记密码？</a>
                              
                    <button type="submit" class="btn btn-primary pull-right">登录</button>
                </form>    
            </div>
        </div>
    </div>   
  </body>
</html>