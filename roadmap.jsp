<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <%@ include file="header.jsp" %>
    <%@ include file="script.jsp" %>
    <title>Axam-项目路线图</title> 
  </head>
  <body>
      <%@include file="navbar.jsp" %>
      <script>setNavbarActive('project_roadmap');</script>
      <div class="container">
        <div class="page-header">
            <h1>项目路线图 <small>Roadmap</small></h1>
        </div>  
        <div role="tabpanel">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active">
                    <a href="#interface" aria-controls="interface" role="tab" data-toggle="tab">前端</a>
                </li>
                <li role="presentation">
                    <a href="#server" aria-controls="server" role="tab" data-toggle="tab">后端</a>
                </li>
            </ul>
        
            <!-- Tab panes -->
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="interface">                  
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>条目</th>
                                <th>状态</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="info">
                                <td>建立新建考试页</td>
                                <td>进行中</td>
                            </tr>
                            <tr>
                                <td>建立用户控制台</td>
                                <td>未开始</td>
                            </tr>
                            <tr class="success">
                                <td>建立数据有效性验证js</td>
                                <td>已完成</td>
                            </tr>
                            <tr class="success">
                                <td>建立注册页</td>
                                <td>已完成</td>
                            </tr>
                            <tr class="success">
                                <td>建立登录页</td>
                                <td>已完成</td>
                            </tr>
                            <tr class="success">
                                <td>实现导航条</td>
                                <td>已完成</td>
                            </tr>
                            <tr class="success">
                                <td>header, script, navbar分离</td>
                                <td>已完成</td>
                            </tr>
                            <tr class="success">
                                <td>实现js自动切换导航标签状态</td>
                                <td>已完成</td>
                            </tr>
                        </tbody>
                    </table>
                    
                    
                </div>
                <div role="tabpanel" class="tab-pane" id="server">
                    <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>条目</th>
                                    <th>状态</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="success">
                                    <td>数据库-题目表</td>
                                    <td>已完成</td>
                                </tr>
                                <tr class="success">
                                    <td>数据库-考试表</td>
                                    <td>已完成</td>
                                </tr>
                                <tr class="success">
                                    <td>实现登录后跳转</td>
                                    <td>已完成</td>
                                </tr>

                                <tr class="success">
                                    <td>建立数据库</td>
                                    <td>已完成</td>
                                </tr>
                                
                                <tr class="success">
                                    <td>实现登录页面，数据有效性不依赖于数据库</td>
                                    <td>已完成</td>
                                </tr>
                            </tbody>
                        </table>
                </div>
            </div>
        </div>
      </div>
      

      
      

  </body>
</html>