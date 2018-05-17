<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    Boolean isStudent = (Boolean)session.getAttribute(application.getInitParameter("ATTR_IS_STUDENT"));
    if (isStudent == null) {
        session.setAttribute(application.getInitParameter("HTML_SIGNIN_ALERT_SIGNIN_FIRST"), true);
        response.sendRedirect("signin.jsp");
        return;
    }
    if (isStudent) {
        response.sendRedirect("dashboard_student.jsp");
    } else {
        response.sendRedirect("dashboard_teacher.jsp");
    }
%>