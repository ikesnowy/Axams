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
              <h1>项目建设中
                <small>Under Construction</small>
              </h1>
            </div>
            <p>
              <strong>项目进度</strong>
            </p>
            <div class="progress">
              <div class="progress-bar progress-bar-info progress-bar-striped active" role="progressbar" aria-valuenow="72" aria-valuemin="0"
                aria-valuemax="100" style="width: 72%; min-width: 2em">
                72%
              </div>
            </div>
            <p>
              <strong>更新日志</strong>
            </p>
            
            
            <div class="panel panel-primary">
                <div class="panel-heading">
                  <h3 class="panel-title">2018年5月8日</h3>
                </div>
                <div class="panel-body">
                  <dl>
                    <dt>界面</dt>
                    <dd>
                      <ol>
                        <li>增加删除问题功能</li>
                      </ol>
                    </dd>
                    <dt>架构</dt>
                    <dd>
                      <ol>
                        <li>增加问题删除后端支持（deleteQuestion.jsp）</li>
                      </ol>
                    </dd>
                  </dl>
                </div>
            </div>
            
            
            <div class="panel panel-info">
                <div class="panel-heading">
                  <h3 class="panel-title">2018年5月7日</h3>
                </div>
                <div class="panel-body">
                  <dl>
                    <dt>界面</dt>
                    <dd>
                      <ol>
                        <li>增加修改问题功能</li>
                      </ol>
                    </dd>
                    <dt>架构</dt>
                    <dd>
                      <ol>
                        <li>修复新建考试时没有自动生成 eid 的问题</li>
                        <li>增加问题内容修改后端支持（modifyQuestion.jsp）</li>
                        <li>为修改问题模态框和添加问题模态框做 id 区分（添加前缀 'add' 以及 'modify'）</li>
                      </ol>
                    </dd>
                  </dl>
                </div>
            </div>
            

            <div class="panel panel-info">
                <div class="panel-heading">
                  <h3 class="panel-title">2018年5月5日</h3>
                </div>
                <div class="panel-body">
                  <dl>
                    <dt>界面</dt>
                    <dd>
                      <ol>
                        <li>完成重复选项提示功能</li>
                      </ol>
                    </dd>
                  </dl>
                </div>
            </div>
            
            
            <div class="panel panel-info">
                <div class="panel-heading">
                  <h3 class="panel-title">2018年4月24日</h3>
                </div>
                <div class="panel-body">
                  <dl>
                    <dt>界面</dt>
                    <dd>
                      <ol>
                        <li>完成添加问题功能</li>
                        <li>为“添加题目”和“修改考试信息”模态框添加表单验证</li>
                        <li>“新增考试”页更名为“修改考试”</li>
                        <li>增加正确答案显示</li>
                      </ol>
                    </dd>
                    <dt>架构</dt>
                    <dd>
                      <ol>
                        <li>添加 server_add_question.jsp，为添加题目提供后端支持</li>
                        <li>添加视图 get_exam_answer_sheet，可以从数据库获取正确答案列表</li>
                      </ol>
                    </dd>
                  </dl>
                </div>
            </div>
            
            <div class="panel panel-info">
                <div class="panel-heading">
                  <h3 class="panel-title">2018年4月23日</h3>
                </div>
                <div class="panel-body">
                  <dl>
                    <dt>界面</dt>
                    <dd>
                      <ol>
                        <li>添加动态增加选项输入框功能</li>
                        <li>添加动态删除选项输入框功能</li>
                        <li>添加动态产生选项数边界提示（2~6个选项）</li>
                      </ol>
                    </dd>
                    <dt>架构</dt>
                    <dd>
                      <ol>
                        <li>现在问题、考试、选项均采用时间戳作为索引</li>
                      </ol>
                    </dd>
                  </dl>
                </div>
            </div>
            
            
            <div class="panel panel-info">
                <div class="panel-heading">
                  <h3 class="panel-title">2018年4月22日</h3>
                </div>
                <div class="panel-body">
                  <dl>
                    <dt>界面</dt>
                    <dd>
                      <ol>
                        <li>添加题目分值显示</li>
                        <li>现在编辑界面的问题可以从数据库中自动读取并显示了</li>
                        <li>增加了添加问题模态框</li>
                      </ol>
                    </dd>
                    <dt>架构</dt>
                    <dd>
                      <ol>
                        <li>aquestion 表中添加了用于存储分值的 qscore 列</li>
                        <li>添加了 AddQuestions 函数，现在问题可以通过 js 动态添加到页面中（Axam.js）</li>
                      </ol>
                    </dd>
                  </dl>
                </div>
            </div>
            

            <div class="panel panel-info">
                <div class="panel-heading">
                  <h3 class="panel-title">2018年4月20日</h3>
                </div>
                <div class="panel-body">
                  <dl>
                    <dt>界面</dt>
                    <dd>
                      <ol>
                        <li>添加考试时间单位</li>
                        <li>现在修改考试信息的输入框内会含有默认值</li>
                      </ol>
                    </dd>
                  </dl>
                </div>
            </div>
            
            <div class="panel panel-info">
              <div class="panel-heading">
                <h3 class="panel-title">2018年4月19日</h3>
              </div>
              <div class="panel-body">
                <dl>
                  <dt>界面</dt>
                  <dd>
                    <ol>
                      <li>添加试卷编辑页（edit_exam.jsp）</li>
                      <li>新增修改考试信息模态框</li>
                    </ol>
                  </dd>
                  <dt>架构</dt>
                  <dd>
                    <ol>
                      <li>利用 AJAX 进行表单上传（Axam.js）</li>
                      <li>添加用于服务器解析 AJAX 数据的代码（server_change_exam_info.jsp）</li>
                    </ol>
                  </dd>
                </dl>

              </div>
            </div>


            <div class="panel panel-info">
              <div class="panel-heading">
                <h3 class="panel-title">2018年4月18日</h3>
              </div>
              <div class="panel-body">
                <dl>
                  <dt>界面</dt>
                  <dd>
                    <ol>
                      <li>增加学生注册和教师注册选择按钮</li>
                    </ol>
                  </dd>
                </dl>
              </div>
            </div>


            <div class="panel panel-info">
              <div class="panel-heading">
                <h3 class="panel-title">2018年4月17日</h3>
              </div>
              <div class="panel-body">
                <dl>
                  <dt>界面</dt>
                  <dd>
                    <ol>
                      <li>增加注册时重复用户校验，已存在的 email 不允许注册</li>
                      <li>现在注册成功后将自动跳转到登陆界面，同时弹出提示</li>
                      <li>增加登录状态校验，阻止未经授权的访问</li>
                      <li>提供教师登录和学生登录的选项</li>
                    </ol>
                  </dd>
                </dl>
              </div>
            </div>

            <div class="panel panel-info">
              <div class="panel-heading">
                <h3 class="panel-title">2018年4月10日</h3>
              </div>
              <div class="panel-body">
                <dl>
                  <dt>界面</dt>
                  <dd>
                    <ol>
                      <li>增加登录页js校验</li>
                    </ol>
                  </dd>
                </dl>
              </div>
            </div>


            <div class="panel panel-info">
              <div class="panel-heading">
                <h3 class="panel-title">2018年4月9日</h3>
              </div>
              <div class="panel-body">
                <dl>
                  <dt>界面</dt>
                  <dd>
                    <ol>
                      <li>增加新建考试页面</li>
                      <li>增加修改考试标题功能</li>
                    </ol>
                  </dd>
                </dl>
              </div>
            </div>


            <div class="panel panel-info">
              <div class="panel-heading">
                <h3 class="panel-title">2018年4月5日</h3>
              </div>
              <div class="panel-body">
                <dl>
                  <dt>界面</dt>
                  <dd>
                    <ol>
                      <li>导航栏现在可以显示登录状态</li>
                      <li>增加登录页错误提示</li>
                      <li>实现退出登录功能</li>
                    </ol>
                  </dd>
                  <dt>架构</dt>
                  <dd>
                    <ol>
                      <li>通过 web.xml 保存 HTML 元素 ID 和 session 属性，实现前后端的进一步解耦</li>
                    </ol>
                  </dd>
                </dl>
              </div>
            </div>


            <div class="panel panel-info">
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
                        将导航条、css 引入语句和 script 引入语句分离成三个文件（navbar.jsp, header.jsp, script.jsp） 使用 include 语句引入，减少冗余。
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