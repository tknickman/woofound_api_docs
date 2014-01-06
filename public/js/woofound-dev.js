
window.onload = function()
{
    document.getElementById("username").onkeyup = function() {
        document.getElementById("username_curl").innerHTML = this.value;
};

    document.getElementById("password").onkeyup = function() {
        document.getElementById("password_curl").innerHTML = this.value;
    };




}