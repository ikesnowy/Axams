<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <%@ include file="header.jsp" %>
    <%@ include file="script.jsp" %>
    <%@ include file="login_check.jsp" %>
    <title>Axam-个人中心</title>
  </head>
  <body>
    <%@include file="navbar.jsp" %>
    <script>setNavbarActive('username');</script>
    <!-- 在这里增加网站内容 -->
    <div class="container">
        <div class="jumbotron">
            <div class="container">
                <h1>欢迎！<%=session.getAttribute(application.getInitParameter("ATTR_USERNAME"))%></h1>
            </div>
        </div>
        
    </div>
    

    
  </body>
</html>