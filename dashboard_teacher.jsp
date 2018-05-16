<%@page import="java.sql.DriverManager"%>  
<%@page import="java.sql.ResultSet"%>  
<%@page import="java.sql.Statement"%>  
<%@page import="java.sql.Connection"%>  
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
        <div class="row">
            <div class="page-header">
                <h1>欢迎回来，<%=session.getAttribute(application.getInitParameter("ATTR_USERNAME"))%> 老师！
                </h1>
            </div>
        </div>
        
        <div class="row">
            <div class="panel panel-default">
                    <div class="panel-body">
                    <h2>考试管理 <a type="button" class="btn btn-default" href="create_exam.jsp">新建考试</a></h2>
                    </div>
                    
                    <table class="table table-hover" id="exam-records-table">
                        <thead>
                            <tr>
                                <th>考试名称</th>
                                <th>创建时间</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody id="exam-records">
                            <%
                                String tid = (String)session.getAttribute(application.getInitParameter("ATTR_USERID"));
                                // 数据库链接  
                                Connection conn = null;  
                                // 向数据库发送sql语句  
                                Statement st = null;  
                                // 结果集  
                                ResultSet rs = null;  
                                String url = "jdbc:mysql://123.206.201.200:3306/Axam";  
                                String userid = "root";  
                                String pass = "acLALDIQc3Qb";
                                String sql = "select * from get_teacher_exam_list where " + application.getInitParameter("DB_TID") + "=" + tid;
                                sql += " order by " + application.getInitParameter("DB_EID") + " desc";
                                try { 
                                    Class.forName("com.mysql.jdbc.Driver");  
                                    //数据库的地址，密码，用户名  
                                    conn = DriverManager.getConnection(url, userid, pass);
                                    st = conn.createStatement();
                                    rs = st.executeQuery(sql);
                                    while (rs.next()) {
                                        String eid = rs.getString(application.getInitParameter("DB_EID"));
                                        String ename = rs.getString(application.getInitParameter("DB_ENAME"));
                                        String epublished = rs.getString(application.getInitParameter("DB_EPUBLISHED"));
                                        out.print("<script>addExamRecord(" + eid + ", '" + ename + "', " + epublished + ");</script>");
                                    }
                                } catch (Exception e) {  
                                    out.print(e.getMessage());
                                    out.print(e);
                                } finally {  
                                    try {  
                                        rs.close();  
                                    } catch (Exception e) {}  
                                    try {  
                                        st.close();  
                                    } catch (Exception e) {}  
                                    try {  
                                        conn.close();  
                                    } catch (Exception e) {}  
                                }
                            %>
                        </tbody>
                    </table>  
            </div>
        </div>
    </div>
    <!-- 确认发布模态框 -->
    <div class="modal fade" id="confirm-publish-model">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">确认发布考试</h4>
                </div>
                <div class="modal-body">
                    <p>确认发布吗？发布后，考试将不能再被编辑！</p>
                    <form id="confirm-publish-form" style="display: none">
                        <input id="exam_id_publish" name="exam_id" type="text" value="0">
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="submitPublishExamForm();">发布</button>
                </div>
            </div>
        </div>
    </div>
    
</body>

</html>