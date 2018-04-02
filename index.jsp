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
                  <div 
                  class="progress-bar progress-bar-info progress-bar-striped active" 
                  role="progressbar" 
                  aria-valuenow="3" aria-valuemin="0" aria-valuemax="100" 
                  style="width: 3%; min-width: 2em">
                     3%
                  </div>
                </div>
                <p><strong>更新日志</strong></p>

                
                <div class="panel panel-primary">
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
      <%@ include file="script.jsp" %>
  </body>
</html>