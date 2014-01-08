
window.onload = function()
{
    $(document).on('input','#username', function () {
        $('#username_curl').html(this.value);
    });

    $(document).on('input','#password', function () {
        $('#password_curl').html(this.value);
    });

    $(document).on('input','#app_secret', function () {
        $('#app_secret_curl').html(this.value);
    });

    $(document).on('input','#id', function () {
        $('#endpoint_curl').html(this.value);
    });


    $('#main_dropdown').change(function(){
        $('#textBoxContainer').empty();

        $('#textBoxContainer').append('<label class="control-label" for="textinput">App_Secret</label><br/><input id="app_secret" name="textinput" size="70" type="text" placeholder="xxxxxxxxxxxx" class="input-xlarge"><br/>');
        $('#textBoxContainer').append('<label class="control-label" for="textinput">Username</label><br/><input id="app_secret" name="textinput" size="20" type="text" placeholder="jason@woofound.com" class="input-xlarge"><br/>');
        $('#textBoxContainer').append('<label class="control-label" for="textinput">Password</label><br/><input id="password" name="textinput" size="20" type="text" placeholder="password" class="input-xlarge"><br/>');

//        TODO: add javascript support for multiple variables in routes - add spans to live update dynamically
        var data = $(this).find('option:selected').attr('value');
        if (data !=  "None"){
            var cleaned_data = data.split("_");
            var num_args = cleaned_data.length;
            for (var i = 0; i < num_args; i++){
                $('#textBoxContainer').append('<label class="control-label" for="textinput">' + cleaned_data[i] + '</label><br/><input id="' + cleaned_data[i] + '" name="textinput" size="25" type="text" placeholder="'+ cleaned_data[i] +'" class="input-xlarge"><br/>');
            }
        }
        $('#textBoxContainer').append('<br/><pre>curl -X GET -H "Woofound-App-Secret: <span id="app_secret_curl" readonly="readonly"></span>"  --user "<span id="username_curl" readonly="readonly"></span>:<span id="password_curl" readonly="readonly"> </span>" https://core.woofound.com<span id="endpoint_curl" readonly="readonly"> </span></pre>');

    });

    var newTextBoxDiv = $(document.createElement('div'))
        .attr("id", 'request_' + counter);


    newTextBoxDiv.after().load("html/request_inner.html",function() {
        $("#nav nav-tabs").find("href").each(function() {
            alert("test");
        });
    });

    newTextBoxDiv.appendTo("#request_group");




};




