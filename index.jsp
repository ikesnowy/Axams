<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <%@ include file="header.jsp" %>
    <%@ include file="script.jsp" %>
    <title>Axam-主页</title>

  </head>
  <body>
      <%@include file="navbar.jsp" %>
      <script>setNavbarActive('project_index');</script>
      <div class="container">
        <div class="row">              
          <div class="col-xs-10 col-sm-10 col-md-10 col-lg-10">
              <div class="page-header">
                  <h1>项目建设中  <small>Under Construction</small></h1>
                </div>         
                <p><strong>项目进度</strong></p>
                <div class="progress">
                  <div 
                  class="progress-bar progress-bar-info progress-bar-striped active" 
                  role="progressbar" 
                  aria-valuenow="12" aria-valuemin="0" aria-valuemax="100" 
                  style="width: 12%; min-width: 2em">
                     12%
                  </div>
                </div>
                <p><strong>更新日志</strong></p>               
                <div class="panel panel-primary">
                    <div class="panel-heading">
                      <h3 class="panel-title">2018年4月3日</h3>
                    </div>
                    <div class="panel-body">
                      <dl>
                        <dt>界面</dt>
                        <dd>
                          <ol>
                            <li>增加登录页</li>
                            <li>增加 Axam.js，现在导航条按钮能够随页面切换自动切换</li>
                          </ol>
                        </dd>
                        <dt>架构</dt>
                        <dd>
                          <ol>
                            <li>将脚本引入放到 head 标签内</li>
                            <li>更新页面模板，增加修改导航条切换语句</li>
                            <li>添加 Axam 数据库</li>
                            <li>增加 server_login.jsp，能够与后台数据库通信确认登录</li>
                          </ol>
                        </dd>
                      </dl>
                    </div>
                </div>
                
                
                <div class="panel panel-info">
                    <div class="panel-heading">
                      <h3 class="panel-title">2018年4月2日</h3>
                    </div>
                    <div class="panel-body">
                      <dl>
                        <dt>界面</dt>
                        <dd>
                          <ol>
                            <li>增加“主页”、“登录”和“注册”按钮</li>
                            <li>重定向 logo 指向的主页</li>
                          </ol>
                        </dd>
                        <dt>架构</dt>
                        <dd>
                          <ol>
                            <li>启用 jsp 文件结构，修改页面扩展名为 jsp</li>
                            <li>
                              将导航条、css 引入语句和 script 引入语句分离成三个文件（navbar.jsp, header.jsp, script.jsp）
                              使用 include 语句引入，减少冗余。
                            </li>
                            <li>
                              增加前端页面模板（template.jsp）
                            </li>
                          </ol>
                        </dd>
                      </dl>
                    </div>
                </div>
                
                <div class="panel panel-info">
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

  </body>
</html>