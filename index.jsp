<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <!DOCTYPE html>
  <html lang="zh-CN">

  <head>
    
    <title>Axam-主页</title>
    <style>
        .bk{background-image: url("bg.jpg");}
        .content{color: azure;
                 text-align: center;
                 font-size: 100px;
                 font-family: 'Times New Roman', Times, serif;
                 padding-top:240px;

        }
        .content1{color: azure;
                 text-align: center;
                 font-size: 50px;
                 font-family:'Courier New', Courier, monospace;
                 padding-top:0px;

        }
        .pic{position: absolute;
             top:50px;}
        
    </style>
  </head>

  <body class="bk">
    <%@include file="navbar.jsp" %>
      <script>setNavbarActive('project_index');</script>
      <div class="content">Axam</div>
      <div class="content1">Online examination system</div>
  </body>
  <%@ include file="header.jsp" %>
  <%@ include file="script.jsp" %>
  </html>