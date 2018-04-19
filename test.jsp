<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
        <title>Axam-新增考试</title>
        <script src="Axam.js"></script>
    </head>
    <body>
        <form method="POST" id="formID">
            <input type="text" name="exam_id" id="exam_id">
            <input type="text" name="exam_name" id="exam_name">
            <input type="text" name="exam_duration" id="exam_duration">
        </form>
        <button type="button" onclick="sendData('formID', 'server_change_exam_info.jsp');">提交</button>        
    </body>
</html>
