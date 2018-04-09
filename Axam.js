// functions for navbar
function setNavbarActive(id)
{
    document.getElementById(id).className="active";
}

function displayElement(id)
{
    document.getElementById(id).removeAttribute('style');
}

function hideElement(id)
{
    document.getElementById(id).setAttribute('style', 'display:none');
}

function changeInnerHTML(id, content)
{
    document.getElementById(id).innerHTML = content;
}

function changeInnerHTMLByInput(targetId, inputId)
{
    var content = new String();
    var appendAfter = new String();
    content = document.getElementById(targetId).innerHTML;
    appendAfter = content.substring(content.indexOf("<"));
    document.getElementById(targetId).innerHTML = document.getElementById(inputId).value + appendAfter;
}

function numberVaildtion(number, min, max)
{
    if (number >= min && number <= max)
    {
        return true;
    }
    return false;
}