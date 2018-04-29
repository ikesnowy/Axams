<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html lang="zh-CN">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
        <!-- Bootstrap -->
        <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
        <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
            crossorigin="anonymous">
        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
            <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
        <title>Axam-新增考试</title>
        <script src="Axam.js"></script>
    </head>

    <body>
        <form id="form_add_question" role="form" enctype="multipart/form-data" action="server_addQuestion.jsp" method="POST">
            <div class="form-group">
                <input name="exam_id" id="exam_id" type="text">
            </div>
            <div class="form-group">
                <input name="question_number" id="question_number" type="number" value="2">
            </div>
            <div class="form-group">
                <input name="option_sum" id="option_sum" type="number" value="2">
            </div>
            <div class="form-group">
                <label for="">题目内容</label>
                <input name="question-content" class="form-control" id="input-question-content" type="text" placeholder="题目内容……" autocomplete="off">
            </div>
            <div class="form-group">
                <label for="">题目分值</label>
                <input name="question-score" class="form-control" id="input-question-score" type="number" placeholder="题目分值……" value="1"
                    autocomplete="off">
            </div>
            <div class="form-group">
                <label>选项列表</label>
            </div>
            <div class="form-group" id="div-option1">
                <div class="input-group">
                    <span class="input-group-addon">A.</span>
                    <input name="option1" class="form-control" id="input-option1" type="text" placeholder="输入选项……" autocomplete="off">
                    <span class="input-group-btn">
                        <button class="btn btn-default" onclick="deleteOption(1);" type="button">
                            <span class="glyphicon glyphicon-minus"></span>
                        </button>
                    </span>
                </div>
            </div>
            <div class="form-group" id="div-option2">
                <div class="input-group">
                    <span class="input-group-addon">B.</span>
                    <input name="option2" class="form-control" id="input-option2" type="text" placeholder="输入选项……"
                        autocomplete="off">
                    <span class="input-group-btn">
                        <button class="btn btn-default" onclick="deleteOption(2);" type="button">
                            <span class="glyphicon glyphicon-minus"></span>
                        </button>
                    </span>
                </div>
            </div>
            <div class="form-group">
                <label>正确答案</label>
                <select name="right-answer" class="form-control" id="select-answer">
                    <option value="1">A</option>
                    <option value="2">B</option>
                </select>
            </div>
            <div class="form-group">
                <button type="submit">提交</button>
            </div>
        </form>
    </body>

    </html>