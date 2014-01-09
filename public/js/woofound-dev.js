
window.onload = function()
{
    //LIVE CURL UPDATE FUNCTIONS
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



    //DYNAMICALLY UPDATING TEXT BOXES
    $('#main_dropdown').change(function(){
        $('#textBoxContainer').empty();

        //check for form values that have already been submitted
        if ($('#autofill').length){
            var app_secret = document.getElementById("app_secret_previous").value;
            var username = document.getElementById("username_previous").value;
            var password = document.getElementById("password_previous").value;
        }
        else{
            var app_secret = '';
            var username = '';
            var password = '';
        }

        //get the value and id of the selected element from the dropdown list
        var data = $(this).find('option:selected').attr('value');
        var route = $(this).find('option:selected').attr('id');

        //don't output the default boxes unless an option has actually been selected
        if (data !=  "blank"){
            //add the universal form boxes (app secret, username, and password)
            $('#textBoxContainer').append('<label class="control-label" for="textinput">App_Secret</label><br/><input id="app_secret" name="post[app_secret]" size="70" type="text" placeholder="xxxxxxxxxxxx" value="' + app_secret + '" class="input-xlarge"><br/>');
            $('#textBoxContainer').append('<label class="control-label" for="textinput">Username</label><br/><input id="username" name="post[username]" size="20" type="text" placeholder="jason@woofound.com" value="' + username + '" class="input-xlarge"><br/>');
            $('#textBoxContainer').append('<label class="control-label" for="textinput">Password</label><br/><input id="password" name="post[password]" size="20" type="text" placeholder="password" value="' + password + '" class="input-xlarge"><br/>');
        }


        //add in a hidden field so we can have access to the chosen route on the backend
        $('#textBoxContainer').append('<input type="hidden" name="post[route]" value="' + route + '">');

        //make sure something was selected
        if (data !=  "None"){
            //split up the variables (they are joined with & in console.erb)
            var cleaned_data = data.split("&");
            var num_args = cleaned_data.length;
            //output the correct number of input boxes for the specific route
            for (var i = 0; i < num_args; i++){
                //build the variable from the data
                var url_replace = "{" + cleaned_data[i] + "}";
                //replace the variables in the route with spans so we can live update them
                route = route.replace(url_replace, '<span id="' + cleaned_data[i] + '_curl" readonly="readonly"> </span>');
                //add  the input box for each variable that corresponds to the span in the curl request example
                $('#textBoxContainer').append('<label class="control-label" for="textinput">' + cleaned_data[i] + '</label><br/><input id="' + cleaned_data[i] + '"name=post[{'+ cleaned_data[i] +'}] size="25" type="text" placeholder="'+ cleaned_data[i] +'" class="input-xlarge"><br/>');
            }
        }

        //add the curl request example
        $('#textBoxContainer').append('<br/><label>Curl:</label><pre>curl -X GET -H "Woofound-App-Secret: <span id="app_secret_curl" readonly="readonly"></span>"  --user "<span id="username_curl" readonly="readonly"></span>:<span id="password_curl" readonly="readonly"> </span>" https://core.woofound.com' + route  + '</pre>');

    });

    //bind to the form submission button
    $( "#singlebutton" ).bind( "click", function() {
        $( "#console_form" ).submit();
    });





};




