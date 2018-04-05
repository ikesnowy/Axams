<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <nav class="navbar navbar-default">
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
        <a class="navbar-brand" href="index.jsp">Axam</a>
      </div>

      <!-- Collect the nav links, forms, and other content for toggling -->
      <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
          <li id="project_index">
            <a href="index.jsp">项目主页
              <span class="sr-only">(current)</span>
            </a>
          </li>
          <li id="project_roadmap">
            <a href="roadmap.jsp">路线图</a>
          </li>
          <li id="index">
            <a href="index.jsp">主页</a>
          </li>
          <li id="new_exam">
            <a href="">新建考试</a>
          </li>
          <li id="take_exam">
            <a href="">参加考试</a>
          </li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
          <li id="sign_in" hidden="hidden">
            <a href="signin.jsp">登录</a>
          </li>
          <li id="sign_up" hidden="hidden">
            <a href="#">注册</a>
          </li>
          <li class="dropdown" id="username" hidden="hidden">
            <a id="dashboard" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">User</a>
            <ul class="dropdown-menu">
              <li>
                <a href="#">个人中心</a>
              </li>
              <li>
                <a href="server_logout.jsp">退出登录</a>
              </li>
            </ul>
          </li>
        </ul>
        <!-- 从 session 中获得当前登陆状态 -->
        <%
                String loginButtonId = application.getInitParameter("HTML_NAVBAR_SIGNIN_BUTTON");
                String registerButtonId = application.getInitParameter("HTML_NAVBAR_SIGNUP_BUTTON");
                String usernameButtonId = application.getInitParameter("HTML_NAVBAR_USER_BUTTON");
                String usernameLabelId = application.getInitParameter("HTML_NAVBAR_USER_NAME");
                String username = (String)session.getAttribute(application.getInitParameter("ATTR_USERNAME"));
                if (username == null)
                {
                  out.print("<script>document.getElementById('" + loginButtonId + "').removeAttribute('style');</script>");
                  out.print("<script>document.getElementById('" + registerButtonId + "').removeAttribute('style');</script>");
                  out.print("<script>document.getElementById('" + usernameButtonId + "').setAttribute('style', 'display:none');</script>");
                }
                else
                {
                  out.print("<script>document.getElementById('" + loginButtonId + "').setAttribute('style', 'display:none');</script>");
                  out.print("<script>document.getElementById('" + registerButtonId + "').setAttribute('style', 'display:none');</script>");
                  out.print("<script>document.getElementById('" + usernameButtonId + "').removeAttribute('style');</script>");
                  out.print("<script>document.getElementById('" + usernameLabelId + "').innerHTML = '" + username + "';</script>");
                }
        %>
      </div>
      <!-- /.navbar-collapse -->
    </div>
    <!-- /.container-fluid -->
  </nav>