<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <%@ include file="header.jsp" %>
    <title>Axam-主页</title>
  </head>
  <body>
      <%@include file="navbar.jsp" %>

      <div class="container">
        <div class="row">              
          <div class="col-xs-10 col-sm-10 col-md-10 col-lg-10">
              <div class="page-header">
                  <h1>项目建设中  <small>Under Construction</small></h1>
                </div>         
                <p><strong>项目进度</strong></p>
                <div class="progress">
                  <div class="progress-bar progress-bar-info progress-bar-striped active" role="progressbar" aria-valuenow="2" aria-valuemin="0" aria-valuemax="100" style="width: 2%; min-width: 2em">
                     2%
                  </div>
                </div>
                <p><strong>更新日志</strong></p>
                
                <div class="panel panel-primary">
                    <div class="panel-heading">
                      <h3 class="panel-title">2018年3月31日</h3>
                    </div>
                    <div class="panel-body">
                       项目主页上线
                    </div>
                </div>
          </div>
        </div>
      </div>
      <%@ include file="script.jsp" %>
  </body>
</html>