// functions for navbar
function setNavbarActive(id)
{
    document.getElementById(id).className="active";
}

function displayElement(id)
{
    document.getElementById(id).removeAttribute("hidden");
}

function hideElement(id)
{
    document.getElementById(id).setAttribute("hidden", "hidden");
}

function changeInnerHTML(id, content)
{
    document.getElementById(id).innerHTML = content;
}

function numberVaildtion(number, min, max)
{
    if (number >= min && number <= max)
    {
        return true;
    }
    return false;
}