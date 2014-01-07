
window.onload = function()
{
    $(document).on('input','#username', function () {
        $('#username_curl').html(this.value);
    })

    $(document).on('input','#password', function () {
        $('#password_curl').html(this.value);
    })

    $(document).on('input','#app_secret', function () {
        $('#app_secret_curl').html(this.value);
    })

    $(document).on('input','#id', function () {
        $('#endpoint_curl').html(this.value);
    })


    $('#dropdown').change(function(){
        $('#textBoxContainer').empty();
        var data = $(this).find('option:selected').attr('value');
        var cleaned_data = data.split("_");
        var num_args = cleaned_data.length;
        for (var i = 0; i < num_args; i++){
            $('#textBoxContainer').append('<label class="control-label" for="textinput">' + cleaned_data[i] + '</label><br/><input id="' + cleaned_data[i] + '" name="textinput" size="25" type="text" placeholder="'+ cleaned_data[i] +'" class="input-xlarge"><br/>');
        }

    });



}




