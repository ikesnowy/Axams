<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html lang="zh-CN">
    <head>
        <%@ include file="header.jsp" %>
        <%@ include file="script.jsp" %>
        <style>body { padding-bottom: 70px; }</style>
        <title>Axam-新增考试</title>
    </head>

    <body>
        <script>setNavbarActive('new_exam');</script>
        <!-- 在这里增加网站内容 -->
        <div class="container">
            
            <div class="row">
                <div class="page-header">
                    <h1 id="exam-title" onmouseover="displayElement('modify_title');" onmouseout="hideElement('modify_title')">考试名称
                        <small>
                            <a id="modify_title" class="glyphicon glyphicon glyphicon-pencil" data-toggle="modal" href='#modal-modify-title'></a>                          
                        </small>
                    </h1>
                </div>
            </div>
            
            <div class="row">
                
                
                <div class="list-group">
                    <a href="#" class="list-group-item">
                        <h4>1.北京奥运会举办于那一年？</h4>
                    </a>
                    <a href="#" class="list-group-item">2008</a>
                    <a href="#" class="list-group-item">2012</a>
                    <a href="#" class="list-group-item">2019</a>
                </div>
                
            </div>
        </div>


        <!-- 各类模态框 -->
        
        <div class="modal fade" id="modal-modify-title">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">修改考试名称</h4>
                    </div>
                    <div class="modal-body">
                        
                        <form action="" method="POST" role="form">   
                            <div class="form-group">
                                <label for="">输入新的考试名称</label>
                                <input type="text" class="form-control" id="input-title" autocomplete="off" placeholder="考试名称……">
                            </div>
                        </form>
                        
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="changeInnerHTMLByInput('exam-title', 'input-title');">确定</button>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 工具条 -->
        
        <nav class="navbar navbar-fixed-bottom navbar-inverse">
                <div class="container-fluid">
                  <!-- Brand and toggle get grouped for better mobile display -->
                  <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                      aria-expanded="false">
                      <span class="sr-only">Toggle navigation</span>
                      <span class="icon-bar"></span>
                      <span class="icon-bar"></span>
                      <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">Axam</a>
                  </div>
            
                  <!-- Collect the nav links, forms, and other content for toggling -->
                  <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <p class="navbar-text">添加题目</p>
                    <ul class="nav navbar-nav navbar-left">
                        <li>
                            <a href="#">选择题</a>
                        </li>
                        <li>
                            <a href="#">判断题</a>
                        </li>
                        <li>
                            <a href="#">主观题</a>
                        </li>                 
                    </ul>

                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href="">保存</a>
                        </li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
              </div>
              <!-- /.container-fluid -->
            </nav>
        
    </body>

    </html>