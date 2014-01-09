
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
        $('#id_curl').html(this.value);
    });

    $(document).on('input','#slider_id', function () {
        $('#slider_id_curl').html(this.value);
    });



    $('#main_dropdown').change(function(){
        $('#textBoxContainer').empty();

        //add the universal form boxes (app secret, username, and password)
        $('#textBoxContainer').append('<label class="control-label" for="textinput">App_Secret</label><br/><input id="app_secret" name="post[app_secret]" size="70" type="text" placeholder="xxxxxxxxxxxx" class="input-xlarge"><br/>');
        $('#textBoxContainer').append('<label class="control-label" for="textinput">Username</label><br/><input id="username" name="post[username]" size="20" type="text" placeholder="jason@woofound.com" class="input-xlarge"><br/>');
        $('#textBoxContainer').append('<label class="control-label" for="textinput">Password</label><br/><input id="password" name="post[password]" size="20" type="text" placeholder="password" class="input-xlarge"><br/>');

        var data = $(this).find('option:selected').attr('value');
        var route = $(this).find('option:selected').attr('id');

        $('#textBoxContainer').append('<input type="hidden" name="post[route]" value="' + route + '">');

        if (data !=  "None"){
            var cleaned_data = data.split("&");
            var num_args = cleaned_data.length;
            for (var i = 0; i < num_args; i++){
                var url_replace = "{" + cleaned_data[i] + "}";
                console.log(url_replace);
                route = route.replace(url_replace, '<span id="' + cleaned_data[i] + '_curl" readonly="readonly"> </span>');
                //add  textbox for each variable
                $('#textBoxContainer').append('<label class="control-label" for="textinput">' + cleaned_data[i] + '</label><br/><input id="' + cleaned_data[i] + '"name=post[{'+ cleaned_data[i] +'}] size="25" type="text" placeholder="'+ cleaned_data[i] +'" class="input-xlarge"><br/>');
            }
        }

        $('#textBoxContainer').append('<br/><label>Curl:</label><pre>curl -X GET -H "Woofound-App-Secret: <span id="app_secret_curl" readonly="readonly"></span>"  --user "<span id="username_curl" readonly="readonly"></span>:<span id="password_curl" readonly="readonly"> </span>" https://core.woofound.com' + route  + '</pre>');

    });


    $( "#singlebutton" ).bind( "click", function() {
        $( "#console_form" ).submit();
    });




};




