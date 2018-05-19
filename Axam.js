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

// submit form
function sendDataSilence(src, formId, targetURL) {
    var XHR = new XMLHttpRequest();

    // We bind the FormData object and the form element
    var f = document.getElementById(formId);
    var FD = new FormData(f);

    // We define what will happen if the data are successfully sent
    XHR.addEventListener("load", function (event) {
        document.getElementById(src).classList.remove("disabled");
        document.getElementById(src).classList.add("active");
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

// add a question to the edit page
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
    h3Question.setAttribute("onmouseover", "displayElement('modify-question-" + number + "');" + "displayElement('delete-question-" + number + "');");
    h3Question.setAttribute("onmouseout", "hideElement('modify-question-" + number + "');" + "hideElement('delete-question-" + number + "');");

    // <small></small>
    var pointContent = document.createTextNode("（" + points + "分）");
    var smallPoint = document.createElement("small");
    smallPoint.appendChild(pointContent);

    // <small></small>
    var smallModifyQuetion = document.createElement("small");
    var aModifyQuestion = document.createElement("a");
    aModifyQuestion.setAttribute("id", "modify-question-" + number);
    aModifyQuestion.setAttribute("style", "display: none");
    aModifyQuestion.classList.add("glyphicon");
    aModifyQuestion.classList.add("glyphicon-pencil");
    aModifyQuestion.setAttribute("onclick", "callModifyQuestionModel(" + id + ", " + number + ", " + points + ");");
    aModifyQuestion.setAttribute("href", "javascript:void(0)");
    smallModifyQuetion.appendChild(aModifyQuestion);

    // <small></small>
    var smallDeleteQuetion = document.createElement("small");
    var aDeleteQuestion = document.createElement("a");
    aDeleteQuestion.setAttribute("id", "delete-question-" + number);
    aDeleteQuestion.setAttribute("style", "display: none");
    aDeleteQuestion.classList.add("glyphicon");
    aDeleteQuestion.classList.add("glyphicon-trash");
    aDeleteQuestion.setAttribute("onclick", "callDeleteQuestionModel(" + id + ");");
    aDeleteQuestion.setAttribute("href", "javascript:void(0)");
    smallDeleteQuetion.appendChild(aDeleteQuestion);

    // </h3>
    h3Question.appendChild(smallPoint);
    h3Question.appendChild(smallDeleteQuetion);
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

function addQuestions_contrast(id, number, points, question, rightAnswer, userAnswer, ...options) {
    // <div class="row">
    var divRow = document.createElement("div");
    divRow.classList.add("row");

    // <div class="col-12">
    var divCol = document.createElement("div");
    divCol.classList.add("col-xs-12", "col-sm-12", "col-md-12", "col-lg-12");

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

    // <small></small>
    var pointContent = document.createTextNode("（" + points + "分）");
    var smallPoint = document.createElement("small");
    smallPoint.appendChild(pointContent);

    // </h3>
    h3Question.appendChild(smallPoint);

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
            if (rightAnswer == userAnswer)
                aOption.classList.add("list-group-item-success");
            else
                aOption.classList.add("list-group-item-info");
        } else if (options[i - 1] == userAnswer) {
            aOption.classList.add("list-group-item-danger");
        }
        divListGroup.appendChild(aOption);
    }

    divCol.appendChild(divListGroup);
    divRow.appendChild(divCol);
    var divAddQuestion = document.getElementById("add-question");
    divAddQuestion.parentNode.insertBefore(divRow, divAddQuestion);
}

function addQuestions_show(id, number, points, question, rightAnswer, ...options) {
    // <div class="row">
    var divRow = document.createElement("div");
    divRow.classList.add("row");

    // <div class="col-12">
    var divCol = document.createElement("div");
    divCol.classList.add("col-xs-12", "col-sm-12", "col-md-12", "col-lg-12");

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

    // <small></small>
    var pointContent = document.createTextNode("（" + points + "分）");
    var smallPoint = document.createElement("small");
    smallPoint.appendChild(pointContent);

    // </h3>
    h3Question.appendChild(smallPoint);

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

    divCol.appendChild(divListGroup);
    divRow.appendChild(divCol);
    var divAddQuestion = document.getElementById("add-question");
    divAddQuestion.parentNode.insertBefore(divRow, divAddQuestion);
}

function addQuestions_do(id, number, points, question, ...options) {
    // <div class="row">
    var divRow = document.createElement("div");
    divRow.classList.add("row");

    // <div class="col-12">
    var divCol = document.createElement("div");
    divCol.classList.add("col-xs-12", "col-sm-12", "col-md-12", "col-lg-12");

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

    // <small></small>
    var pointContent = document.createTextNode("（" + points + "分）");
    var smallPoint = document.createElement("small");
    smallPoint.appendChild(pointContent);

    // </h3>
    h3Question.appendChild(smallPoint);

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
        divListGroup.appendChild(aOption);
    }

    divCol.appendChild(divListGroup);
    divRow.appendChild(divCol);
    var divAddQuestion = document.getElementById("add-question");
    divAddQuestion.parentNode.insertBefore(divRow, divAddQuestion);
}

function setOptionsClickEvent(qid, qnumber, ...oids) {
    for (var i = 1; i <= oids.length; i++) {
        var aOption = document.getElementById("option-" + qnumber + "-" + i);
        aOption.setAttribute("onclick", "makeCoice(" + qnumber + ", '" + qid + "', '" + oids[i - 1] + "', " + oids.length + ", " + i + ");");
    }    
}

function makeCoice(qnumber, qid, oid, osum, src) {
    for (var i = 1; i <= osum; i++)
        document.getElementById("option-" + qnumber + "-" + i).classList.remove("active");
    document.getElementById("option-" + qnumber + "-" + src).classList.add("disabled");
    document.getElementById("make-choice-qid").setAttribute("value", qid);
    document.getElementById("make-choice-oid").setAttribute("value", oid);
    sendDataSilence("option-" + qnumber + "-" + src, "form-make-choice", "server_make_choice.jsp");
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
    } else if (parseInt(document.getElementById(prefix + "-input-question-score").value) < 0) {
        makeAlert("form_" + prefix + "_question", "question_form_alert", "分值不能为负", "");
        document.getElementById(prefix + "-div-question-score").classList.add("has-error");
        return false;
    }
    else {
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
    } else if (parseInt(document.getElementById("input-duration").value) < 0) {
        makeAlert("div-duration", "alter_exam_alert", "考试时间不能为负！", "");
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

function submitDeleteQuestionForm() {
    sendData("form_delete_question", "server_deleteQuestion.jsp");
}

function submitPublishExamForm() {
    sendData("confirm-publish-form", "server_publishExam.jsp");
}

function submitDeleteExamForm() {
    sendData("confirm-delete-form", "server_deleteExam.jsp");
}

function callModifyQuestionModel(qid, qnumber, score) {
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

    document.getElementById("modify-input-question-score").setAttribute("value", score);

    $('#modal-modify-choice-question').modal();
}

function callDeleteQuestionModel(qid) {
    document.getElementById("delete-question_id").setAttribute("value", qid);
    $('#modal-delete-choice-question').modal();
}

function callPublishExamModel(eid) {
    document.getElementById("exam_id_publish").setAttribute("value", eid);
    $('#confirm-publish-model').modal();
}

function callDeleteExamModel(eid) {
    document.getElementById("exam_id_delete").setAttribute("value", eid);
    $('#confirm-delete-exam-model').modal();
}

function callShowExamIDModal(eid) {
    document.getElementById("exam_id_show").setAttribute("value", eid);
    $('#get-exam-id-model').modal();
}

function addExamRecord(eid, ename, epublished) {
    var tr = document.createElement("tr");
    var tdEName = document.createElement("td");
    var textEName = document.createTextNode(ename);
    tdEName.appendChild(textEName);
    tr.appendChild(tdEName);

    var tdDate = document.createElement("td");
    var createDate = new Date(eid).toLocaleDateString();
    var textDate = document.createTextNode(createDate);
    tdDate.appendChild(textDate);
    tr.appendChild(tdDate);

    var tdEPub = document.createElement("td");
    if (epublished == 0) {
        var textPub = document.createTextNode("未发布");
        tdEPub.appendChild(textPub);
    } else {
        var textPub = document.createTextNode("已发布（");
        tdEPub.appendChild(textPub);
        var aGetExamID = document.createElement("a");
        var textGetExamID = document.createTextNode("获取考试 ID");
        aGetExamID.setAttribute("href", "javascript:void(0);");
        aGetExamID.setAttribute("onclick", "callShowExamIDModal('" + eid + "');");
        aGetExamID.appendChild(textGetExamID);
        tdEPub.appendChild(aGetExamID);
        var textRightBracket = document.createTextNode("）");
        tdEPub.appendChild(textRightBracket);
    }
    tr.appendChild(tdEPub);

    var tdEOperation = document.createElement("td");
    var aDeleteExam = document.createElement("a");
    var textDelete = document.createTextNode("删除");
    aDeleteExam.setAttribute("href", "javascript:void(0);");
    aDeleteExam.setAttribute("onclick", "callDeleteExamModel('" + eid + "');");
    aDeleteExam.appendChild(textDelete);
    tdEOperation.appendChild(aDeleteExam);

    var textSpace1 = document.createTextNode(" ");
    tdEOperation.appendChild(textSpace1);

    if (epublished == 0) {
        var aEditExam = document.createElement("a");
        var textEditExam = document.createTextNode("编辑");
        aEditExam.setAttribute("href", "edit_exam.jsp?eid=" + eid);
        aEditExam.appendChild(textEditExam);
        tdEOperation.appendChild(aEditExam);

        var textSpace2 = document.createTextNode(" ");
        tdEOperation.appendChild(textSpace2);

        var aPublishExam = document.createElement("a");
        var textPublishExam = document.createTextNode("发布");
        aPublishExam.setAttribute("href", "javascript:void(0);");
        aPublishExam.setAttribute("onclick", "callPublishExamModel('" + eid + "');");
        aPublishExam.appendChild(textPublishExam);
        tdEOperation.appendChild(aPublishExam);

        var textSpace3 = document.createTextNode(" ");
        tdEOperation.appendChild(textSpace3);
    } else {
        var aShowExamResult = document.createElement("a");
        var textShowExamResult = document.createTextNode("查看结果");
        aShowExamResult.setAttribute("href", "show_exam_result_teacher.jsp?eid=" + eid);
        aShowExamResult.appendChild(textShowExamResult);
        tdEOperation.appendChild(aShowExamResult);

        var textSpace4 = document.createTextNode(" ");
        tdEOperation.appendChild(textSpace4);


    }

    tr.appendChild(tdEOperation);
    var table = document.getElementById("exam-records");
    table.appendChild(tr);
}

function startTimer(minutes) {    
    var hour = 0;
    var minute = 0;
    var second = 0;
    if (minutes >= 60) {
        hour = parseInt(minutes / 60);
        minute = minutes % 60;
    } else {
        minute = minutes;
    }
    updateTimeLeft(hour, minute, second);
    decTime();
}

function updateTimeLeft(hour, minute, second) {
    var clock = document.getElementById("time-left");
    var clockText = "";
    clockText += hour < 10 ? "0" + hour : hour;
    clockText += ":";
    clockText += minute < 10 ? "0" + minute : minute;
    clockText += ":";
    clockText += second < 10 ? "0" + second : second;
    clock.innerText = clockText;
}

function decTime() {
    var nowTimeString = document.getElementById("time-left").innerText.split(":");
    var hour = parseInt(nowTimeString[0]);
    var minute = parseInt(nowTimeString[1]);
    var second = parseInt(nowTimeString[2]);
    second--;
    if (second < 0) {
        second = 59;
        minute--;
        if (minute < 0) {
            minute = 59;
            hour--;
            if (hour < 0) {
                examTimeOut();
                return;
            }
        }
    }
    updateTimeLeft(hour, minute, second);
    setTimeout("decTime()", 1000);
}

function examTimeOut() {
    alert("考试时间到！");
    location.href(document.getElementById("submit-exam").getAttribute("href"));
}

function changeHref(id, sid, eid) {
    document.getElementById(id).setAttribute("href", "server_grade.jsp?sid=" + sid + "&eid=" + eid);
}