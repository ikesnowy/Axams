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