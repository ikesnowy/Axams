// functions for navbar
function setNavbarActive(id) {
    document.getElementById(id).classList.toggle('active');
}

// common functions
function displayElement(id) {
    document.getElementById(id).removeAttribute('style');
    document.getElementById(id).removeAttribute('hidden');
}

function hideElement(id) {
    document.getElementById(id).setAttribute('style', 'display:none');
    document.getElementById(id).setAttribute('hidden', 'hidden');
}

function changeInnerHTML(id, content) {
    document.getElementById(id).innerHTML = content;
}

function changeInnerHTMLByInput(targetId, inputId) {
    if (document.getElementById(inputId).value.length == 0)
        return;
    var content = new String();
    var appendAfter = new String();
    content = document.getElementById(targetId).innerHTML;
    appendAfter = content.substring(content.indexOf("<"));
    document.getElementById(targetId).innerHTML = document.getElementById(inputId).value + appendAfter;
}

function disableControl(id) {
    document.getElementById(id).setAttribute('disabled', 'disabled');
}

function enableControl(id) {
    document.getElementById(id).removeAttribute('disabled');
}

// functions for form validations
function numberValidation(number, min, max) {
    if (number > min && number <= max) {
        return true;
    }
    return false;
}

function stringLengthValidation(inputId, min, max) {
    if (document.getElementById(inputId).value.length <= min ||
        document.getElementById(inputId).value.length > max) {
        return false;
    }
    return true;
}

function emailValidation(inputId, divId, successId, failedId) {
    const regEmail = /^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$/;
    if (document.getElementById(inputId).value == null) {
        return false;
    }
    if (!document.getElementById(inputId).value.match(regEmail) ||
        document.getElementById(inputId).value.length > 100) {
        document.getElementById(divId).classList.remove('has-success');
        document.getElementById(divId).classList.add('has-error', 'has-feedback');
        displayElement(failedId);
        hideElement(successId);
        return false;
    }
    else {
        document.getElementById(divId).classList.remove('has-error');
        document.getElementById(divId).classList.add('has-success', 'has-feedback');
        displayElement(successId);
        hideElement(failedId);
        return true;
    }
}

function passwordValidation(inputId, divId, successId, failedId) {
    if (document.getElementById(inputId).value == null) {
        return false;
    }
    if (document.getElementById(inputId).value.length < 6 ||
        document.getElementById(inputId).value.length > 18) {
        document.getElementById(divId).classList.remove('has-success');
        document.getElementById(divId).classList.add('has-error', 'has-feedback');
        displayElement(failedId);
        hideElement(successId);
        return false;
    }
    else {
        document.getElementById(divId).classList.remove('has-error');
        document.getElementById(divId).classList.add('has-success', 'has-feedback');
        displayElement(successId);
        hideElement(failedId);
        return true;
    }
}

function usernameValidation(inputId, divId, successId, failedId) {
    if (document.getElementById(inputId).value == null) {
        return false;
    }
    if (document.getElementById(inputId).value.length > 10) {
        document.getElementById(divId).classList.remove('has-success');
        document.getElementById(divId).classList.add('has-error', 'has-feedback');
        displayElement(failedId);
        hideElement(successId);
        return false;
    }
    else {
        document.getElementById(divId).classList.remove('has-error');
        document.getElementById(divId).classList.add('has-success', 'has-feedback');
        displayElement(successId);
        hideElement(failedId);
        return true;
    }
}

function loginValidation(emailInput, emailDiv, emailSuccess, emailFailed, passwordInput, passwordDiv, passwordSuccess, passwordFailed, submitButton) {
    if (emailValidation(emailInput, emailDiv, emailSuccess, emailFailed) &&
        passwordValidation(passwordInput, passwordDiv, passwordSuccess, passwordFailed)) {
        enableControl(submitButton);
    }
    else {
        disableControl(submitButton);
    }
}

function registerValidation(usernameInput, usernameDiv, usernameSuccess, usernameFailed, emailInput, emailDiv, emailSuccess, emailFailed, passwordInput, passwordDiv, passwordSuccess, passwordFailed, submitButton) {
    if (usernameValidation(usernameInput, usernameDiv, usernameSuccess, usernameFailed) &&
        emailValidation(emailInput, emailDiv, emailSuccess, emailFailed) &&
        passwordValidation(passwordInput, passwordDiv, passwordSuccess, passwordFailed)) {
        enableControl(submitButton);
    }
    else {
        disableControl(submitButton);
    }
}

function questionValidation(inputId, divId, failedId) {
    if (!stringLengthValidation(inputId, 0, 500)) {
        document.getElementById(divId).classList.add('has-error', 'has-feedback');
        displayElement(failedId);
    }
    else {
        document.getElementById(divId).classList.remove('has-error', 'has-feedback');
        hideElement(failedId);
    }
}

function optionValidation(inputId, divId, failedId) {
    if (!stringLengthValidation(inputId, 0, 100)) {
        document.getElementById(divId).classList.add('has-error', 'has-feedback');
        displayElement(failedId);
    }
    else {
        document.getElementById(divId).classList.remove('has-error', 'has-feedback');
        hideElement(failedId);
    }
}

// js for edit exam
function changeInputValue(inputId, newVal) {
    document.getElementById(inputId).setAttribute('value', newVal);
}

// submit form
function sendData(formId, targetURL) {
    var XHR = new XMLHttpRequest();

    // We bind the FormData object and the form element
    var f = document.getElementById(formId);
    var FD = new FormData(f);

    // We define what will happen if the data are successfully sent
    XHR.addEventListener("load", function (event) {
        location.reload();
    });

    // We define what will happen if case of error
    XHR.addEventListener("error", function (event) {
        alert('Oups! Something goes wrong.');
    });

    // We setup our request
    XHR.open("POST", targetURL);
    // XHR.setRequestHeader("Content-Type", "multipart/form-data");

    // The data send are the one the user provide in the form
    XHR.send(FD);
}

// add a question to the page
function addQuestions(id, number, points, question, rightAnswer, ...options) {
    // <div class="row">
    var divRow = document.createElement("div");
    divRow.classList.add("row");

    // <div class="list-group">
    var divListGroup = document.createElement("div");
    divListGroup.classList.add("list-group");

    // <li class="list-group-item">
    var liQuestion = document.createElement("li");
    liQuestion.classList.add("list-group-item");

    // <h3>
    var questionContent = document.createTextNode(number + "." + question);
    var h3Question = document.createElement("h3");
    h3Question.appendChild(questionContent);
    h3Question.setAttribute("onmouseover", "displayElement('modify-question-" + number + "');");
    h3Question.setAttribute("onmouseout", "hideElement('modify-question-" + number + "');");

    // <small></small>
    var pointContent = document.createTextNode("（" + points + "分）");
    var smallPoint = document.createElement("small");
    smallPoint.appendChild(pointContent);

    // <small></small>
    var smallModifyQuetion = document.createElement("small");
    var aModifyQuestion = document.createElement("a");
    aModifyQuestion.setAttribute("id", "modify-question-" + number);
    aModifyQuestion.classList.add("glyphicon");
    aModifyQuestion.classList.add("glyphicon-pencil");
    aModifyQuestion.setAttribute("onclick", "callModifyQuestionModel(" + id + ", " + number + ");");
    aModifyQuestion.setAttribute("href", "javascript:void(0)");
    smallModifyQuetion.appendChild(aModifyQuestion);
    
    // </h3>
    h3Question.appendChild(smallPoint);
    h3Question.appendChild(smallModifyQuetion);

    // </li>
    liQuestion.appendChild(h3Question);
    divListGroup.appendChild(liQuestion);

    var optionMark = new Array(
    'A', 'B', 'C', 'D', 'E', 'F', 'G',
    'H', 'I', 'J', 'K', 'L', 'M', 'N',
    'O', 'P', 'Q', 'R', 'S', 'T',
    'U', 'V', 'W', 'X', 'Y', 'Z');

    // add Question content
    var aQuestionContent = document.createElement("a");
    var pureQuestionContent = document.createTextNode(question);
    aQuestionContent.setAttribute("id", "question-" + number);
    aQuestionContent.setAttribute("style", "display: none");
    aQuestionContent.appendChild(pureQuestionContent);
    divListGroup.appendChild(aQuestionContent);

    // add Question point
    var aQuestionPoint = document.createElement("a");
    var pointValue = document.createTextNode(points + "");
    aQuestionPoint.setAttribute("id", "question-point-" + number);
    aQuestionPoint.setAttribute("style", "display: none");
    aQuestionPoint.appendChild(pointValue);
    divListGroup.appendChild(aQuestionPoint);

    // add option sum
    var aOptionSum = document.createElement("a");
    var optionSumText = document.createTextNode(options.length + "");
    aOptionSum.setAttribute("id", "option-sum-" + number);
    aOptionSum.setAttribute("style", "display: none");
    aOptionSum.appendChild(optionSumText);
    divListGroup.appendChild(aOptionSum);
    
    // add options
    for (var i = 1; i <= options.length; i++) {
        var optionContent = document.createTextNode(optionMark[i - 1] + "." + options[i - 1]);
        var aOption = document.createElement("a");
        aOption.appendChild(optionContent);
        aOption.setAttribute("id", "option-" + number + "-" + i);
        aOption.setAttribute("href", "javascript:void(0)");
        aOption.classList.add("list-group-item");
        if (options[i - 1] == rightAnswer) {
            aOption.classList.add("list-group-item-success");
        }
        divListGroup.appendChild(aOption);
    }

    divRow.appendChild(divListGroup);
    var divAddQuestion = document.getElementById("add-question");
    divAddQuestion.parentNode.insertBefore(divRow, divAddQuestion);
}

// add new option input box
function addOptions(prefix) {
    var optionMark = new Array(
        'A', 'B', 'C', 'D', 'E', 'F', 'G',
        'H', 'I', 'J', 'K', 'L', 'M', 'N',
        'O', 'P', 'Q', 'R', 'S', 'T',
        'U', 'V', 'W', 'X', 'Y', 'Z');

    // Add option sums
    var number = document.getElementById(prefix + "-option_sum").value;
    if (number == 6) {
        makeAlert(prefix + "-div-option1", "options_error", "最多含有6个选项", "");
        return;
    }
    number++;
    document.getElementById(prefix + "-option_sum").setAttribute("value", number);
    // Create option input
    var divFormGroup = document.createElement("div");
    divFormGroup.classList.add("form-group");
    divFormGroup.setAttribute("id", prefix + "-div-option" + number);

    var divInputGroup = document.createElement("div");
    divInputGroup.classList.add("input-group");

    var spanItemMark = document.createElement("span");
    var itemMark = document.createTextNode(optionMark[number - 1] + ".");
    spanItemMark.classList.add("input-group-addon");
    spanItemMark.appendChild(itemMark);

    divInputGroup.appendChild(spanItemMark);

    var inputOption = document.createElement("input");
    inputOption.setAttribute("type", "text");
    inputOption.setAttribute("name", "option" + number);
    inputOption.setAttribute("id", prefix + "-input-option" + number);
    inputOption.setAttribute("autocomplete", "off");
    inputOption.setAttribute("placeholder", "输入选项……");
    inputOption.classList.add("form-control");
    divInputGroup.appendChild(inputOption);

    var spanDeleteButton = document.createElement("span");
    spanDeleteButton.classList.add("input-group-btn");
    var buttonDelete = document.createElement("button");
    buttonDelete.setAttribute("type", "button");
    buttonDelete.setAttribute("onclick", "deleteOption('" + prefix + "', " + number + ");");
    buttonDelete.classList.add("btn", "btn-default");
    var spanDeleteMark = document.createElement("span");
    spanDeleteMark.classList.add("glyphicon", "glyphicon-minus");
    buttonDelete.appendChild(spanDeleteMark);
    spanDeleteButton.appendChild(buttonDelete);
    divInputGroup.appendChild(spanDeleteButton);
    divFormGroup.appendChild(divInputGroup);

    var current = document.getElementById(prefix + "-add-options");
    current.parentNode.insertBefore(divFormGroup, current);

    // add selection
    document.getElementById(prefix + "-select-answer").options.add(new Option(optionMark[number - 1], number));
}

// delete a option box
function deleteOption(prefix, index) {
    // option sum - 1
    var number = document.getElementById(prefix + "-option_sum").value;
    var sum = parseInt(number);
    if (sum == 0 || sum == 1) {
        return;
    }
    if (sum == 2) {
        // make Alert
        makeAlert(prefix + "-div-option1", "options_error", "至少包含两个选项", "");
        return;
    }

    // move option value
    for (var i = index; i < number; i++) {
        var next = i + 1;
        var nextInput = document.getElementById(prefix + "-input-option" + next);
        document.getElementById(prefix + "-input-option" + i).value = nextInput.value;
    }

    // delete the final option input
    var form = document.getElementById("form_" + prefix + "_question");
    form.removeChild(document.getElementById(prefix + "-div-option" + number));

    number--;
    document.getElementById(prefix + "-option_sum").setAttribute("value", number);

    // delete the final selection
    var selection = document.getElementById(prefix + "-select-answer");
    selection.remove(number);
}

// clear all option box
function initOptions(prefix) {
    // reset option sum
    var number = document.getElementById(prefix + "-option_sum").value;
    document.getElementById(prefix + "-option_sum").setAttribute("value", 0);

    // delete all options and selections
    var form = document.getElementById("form_" + prefix + "_question");
    var selection = document.getElementById(prefix + "-select-answer");
    for (var i = 1; i <= number; i++) {
        form.removeChild(document.getElementById(prefix + "-div-option" + i));
        selection.options.remove(0);
    }
    addOptions(prefix);
    addOptions(prefix);
}

// create a alert box
function makeAlert(before, alertId, title, content) {
    if (document.getElementById(alertId) != null) {
        $("#" + alertId).alert('close');
    }
    var divAlert = document.createElement("div");
    divAlert.classList.add("alert", "alert-danger");
    divAlert.setAttribute("id", alertId);
    var btnDismiss = document.createElement("button");
    btnDismiss.setAttribute("type", "button");
    btnDismiss.classList.add("close");
    btnDismiss.setAttribute("data-dismiss", "alert");
    btnDismiss.setAttribute("aria-hidden", "true");
    var timesMark = document.createTextNode("×");
    btnDismiss.appendChild(timesMark);
    divAlert.appendChild(btnDismiss);

    var strongTitle = document.createElement("strong");
    var titleContent = document.createTextNode(title);
    strongTitle.appendChild(titleContent);
    divAlert.appendChild(strongTitle);

    var alertContent = document.createTextNode(content);
    divAlert.appendChild(alertContent);
    var current = document.getElementById(before);
    current.parentNode.insertBefore(divAlert, current);
}

// validation for question form
function checkQuestionForm(prefix) {
    if (document.getElementById(prefix + "-input-question-content").value.length == 0) {
        document.getElementById(prefix + "-div-question-content").classList.add("has-error");
        makeAlert("form_" + prefix + "_question", "question_form_alert", "题目内容不能为空", "");
        return false;
    } else if (document.getElementById(prefix + "-input-question-content").value.length > 110) {
        document.getElementById(prefix + "-div-question-content").classList.add("has-error");
        makeAlert("form_" + prefix + "_question", "question_form_alert", "题目内容太长", "");
        return false;
    } else {
        document.getElementById(prefix + "-div-question-content").classList.remove("has-error");
    }
    if (document.getElementById(prefix + "-input-question-score").value.length == 0) {
        makeAlert("form_" + prefix + "_question", "question_form_alert", "分值不能为空", "");
        document.getElementById(prefix + "-div-question-score").classList.add("has-error");
        return false;
    } else {
        document.getElementById(prefix + "-div-question-score").classList.remove("has-error");
    }
    if (document.getElementById(prefix + "-input-question-score").value.length > 3) {
        makeAlert("form_" + prefix + "_question", "question_form_alert", "分值太大", "");
        document.getElementById(prefix + "-div-question-score").classList.add("has-error");
        return false;
    } else {
        document.getElementById(prefix + "-div-question-score").classList.remove("has-error");
    }

    var num = document.getElementById(prefix + "-option_sum").value;
    var sum = parseInt(num);
    for (var i = 1; i <= sum; i++) {
        if (document.getElementById(prefix + "-input-option" + i).value.length == 0) {
            makeAlert("form_" + prefix + "_question", "question_form_alert", "选项不能为空！", "");
            document.getElementById(prefix + "-div-option" + i).classList.add("has-error");
            return false;
        } else if (document.getElementById(prefix + "-input-option" + i).value.length >= 200) {
            makeAlert("form_" + prefix + "_question", "question_form_alert", "选项太长！", "");
            document.getElementById(prefix + "-div-option" + i).classList.add("has-error");
            return false;
        } else {
            document.getElementById(prefix + "-div-option" + i).classList.remove("has-error");
        }
    }

    for (var i = 1; i <= sum; i++) {
        for (var j = i + 1; j <= sum; j++) {
            var op1 = document.getElementById(prefix + "-input-option" + i).value;
            var op2 = document.getElementById(prefix + "-input-option" + j).value;
            if (op1 == op2) {
                makeAlert("form_" + prefix + "_question", "question_form_alert", "重复的选项！", "");
                document.getElementById(prefix + "-div-option" + i).classList.add("has-error");
                document.getElementById(prefix + "-div-option" + j).classList.add("has-error");
                return false;
            }
        }
    }

    return true;
}

// validation for modify exam form
function checkAlterExamForm() {
    if (document.getElementById("input-title").value.length == 0) {
        makeAlert("div-title", "alter_exam_alert", "考试标题不能为空！", "");
        document.getElementById("div-title").classList.add("has-error");
        return false;
    } else if (document.getElementById("input-title").value.length > 30) {
        makeAlert("div-title", "alter_exam_alert", "考试名称太长！", "");
        document.getElementById("div-title").classList.add("has-error");
        return false;
    } else {
        document.getElementById("div-title").classList.remove("has-error");
    }

    if (document.getElementById("input-duration").value.length == 0) {
        makeAlert("div-duration", "alter_exam_alert", "考试时长不能为空！", "");
        document.getElementById("div-duration").classList.add("has-error");
        return false;
    } else if (document.getElementById("input-duration").value.length > 5) {
        makeAlert("div-duration", "alter_exam_alert", "考试时间太长！", "");
        document.getElementById("div-duration").classList.add("has-error");
        return false;
    } else {
        document.getElementById("div-duration").classList.remove("has-error");
    }

    return true;
}

function submitAddQuestionForm() {
    if (checkQuestionForm('add') == false) {
        return;
    }
    sendData("form_add_question", "server_addQuestion.jsp");
}

function submitModifyQuestionForm() {
    if (checkQuestionForm('modify') == false) {
        return;
    }
    sendData("form_modify_question", "server_modifyQuestion.jsp");
}

function submitAlterExamForm() {
    if (checkAlterExamForm() == false) {
        return;
    }
    sendData("form_change_exam_info", "server_change_exam_info.jsp");
}

function callModifyQuestionModel(qid, qnumber) {
    initOptions("modify");
    var optionSum = parseInt(document.getElementById("option-sum-" + qnumber).innerText);
    if (optionSum > 2) {
        for (var i = 2; i < optionSum; i++) {
            addOptions("modify");
        }
    }

    for (var i = 1; i <= optionSum; i++) {
        var optionContent = document.getElementById("option-" + qnumber + "-" + i).innerText;
        document.getElementById("modify-input-option" + i).setAttribute("value", optionContent.substr(2));
    }
    
    var questionContent = document.getElementById("question-" + qnumber).innerText;
    document.getElementById("modify-input-question-content").setAttribute("value", questionContent);

    document.getElementById("modify-question_id").setAttribute("value", qid);

    $('#modal-modify-choice-question').modal();
}