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

function addQuestions(number, points, question, ...options) {
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
    for(var i = 0; i < options.length; i++) {
        var optionContent = document.createTextNode(optionMark[i] + "." + options[i]);
        var aOption = document.createElement("a");
        aOption.appendChild(optionContent);
        aOption.setAttribute("href", "javascript:void(0)");
        aOption.classList.add("list-group-item");
        divListGroup.appendChild(aOption);
    }

    divRow.appendChild(divListGroup);
    var divAddQuestion = document.getElementById("add-question");
    divAddQuestion.parentNode.insertBefore(divRow, divAddQuestion);
}

function addOptions() {
    var optionMark = new Array(
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 
        'H', 'I', 'J', 'K', 'L', 'M', 'N', 
        'O', 'P', 'Q', 'R', 'S', 'T', 
        'U', 'V', 'W', 'X', 'Y', 'Z');

    // Add option sums
    var number = document.getElementById("option_sum").value;
    if (number == 6) {
        makeAlert("div-option1", "options_error", "最多含有6个选项", "");
        return;
    }
    number++;
    document.getElementById("option_sum").setAttribute("value", number);
    // Create option input
    var divFormGroup = document.createElement("div");
    divFormGroup.classList.add("form-group");
    divFormGroup.setAttribute("id", "div-option" + number);

    var divInputGroup = document.createElement("div");
    divInputGroup.classList.add("input-group");

    var spanItemMark = document.createElement("span");
    var itemMark =document.createTextNode(optionMark[number - 1] + ".");
    spanItemMark.classList.add("input-group-addon");
    spanItemMark.appendChild(itemMark);
    
    divInputGroup.appendChild(spanItemMark);

    var inputOption = document.createElement("input");
    inputOption.setAttribute("type", "text");
    inputOption.setAttribute("name", "option" + number);
    inputOption.setAttribute("id", "input-option" + number);
    inputOption.setAttribute("autocomplete", "off");
    inputOption.setAttribute("placeholder", "输入选项……");
    inputOption.classList.add("form-control");
    divInputGroup.appendChild(inputOption);

    var spanDeleteButton = document.createElement("span");
    spanDeleteButton.classList.add("input-group-btn");
    var buttonDelete = document.createElement("button");
    buttonDelete.setAttribute("type", "button");
    buttonDelete.setAttribute("onclick", "deleteOption(" + number + ");");
    buttonDelete.classList.add("btn", "btn-default");
    var spanDeleteMark = document.createElement("span");
    spanDeleteMark.classList.add("glyphicon", "glyphicon-minus");
    buttonDelete.appendChild(spanDeleteMark);
    spanDeleteButton.appendChild(buttonDelete);
    divInputGroup.appendChild(spanDeleteButton);
    divFormGroup.appendChild(divInputGroup);

    var current = document.getElementById("add-options");
    current.parentNode.insertBefore(divFormGroup, current);

    // add selection
    document.getElementById("select-answer").options.add(new Option(optionMark[number - 1], number));
}

function initOptions(){
    // reset option sum
    var number = document.getElementById("option_sum").value;
    document.getElementById("option_sum").setAttribute("value", 0);

    // delete all options and selections
    var form = document.getElementById("form_add_question");
    var selection = document.getElementById("select-answer");
    for (var i = 1; i <= number; i++) {
        form.removeChild(document.getElementById("div-option" + i));
        selection.options.remove(0);
    }
    addOptions();
    addOptions();
}

function deleteOption(index) {
    // option sum - 1
    var number = document.getElementById("option_sum").value;
    var sum = parseInt(number);
    if (sum == 0 || sum == 1) {
        return;
    }
    if (sum == 2) {
        // make Alert
        makeAlert("div-option1", "options_error", "至少包含两个选项", "");
        return;
    }
    
    // move option value
    for (var i = index; i < number; i++) {
        var next = i + 1;
        var nextInput = document.getElementById("input-option" + next);
        document.getElementById("input-option" + i).value=nextInput.value;
    }

    // delete the final option input
    var form = document.getElementById("form_add_question");
    form.removeChild(document.getElementById("div-option" + number));

    number--;
    document.getElementById("option_sum").setAttribute("value", number);

    // delete the final selection
    var selection = document.getElementById("select-answer");
    selection.remove(number);
}

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

function checkQuestionForm() {
    if (document.getElementById("input-question-content").value == null) {
        return false;
    } else if (document.getElementById("input-question-score").value == null) {
        return false;
    }
    var num = document.getElementById("option_sum").value;
    var sum = parseInt(num);
    for (var i = 1; i <= sum; i++) {
        if (document.getElementById("input-option" + i).value == null) {
            return false;
        }
    }
    return true;
}

function submitAddQuestionForm() {
    if (checkQuestionForm() == false) {
        makeAlert("form_add_question", "question_form_alert", "所有表单项均为必填！", "");
        return;
    }
    sendData("form_add_question", "server_addQuestion.jsp");
}