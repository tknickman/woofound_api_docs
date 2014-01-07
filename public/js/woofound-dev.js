
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


    $('#dropdown').change(function(){
        $('#textBoxContainer').empty();
        var data = $(this).find('option:selected').attr('value');
        var cleaned_data = data.split("_");
        var num_args = cleaned_data.length;
        for (var i = 0; i < num_args; i++){
            $('#textBoxContainer').append('<label class="control-label" for="textinput">' + cleaned_data[i] + '</label><br/><input id="' + cleaned_data[i] + '" name="textinput" size="25" type="text" placeholder="'+ cleaned_data[i] +'" class="input-xlarge"><br/>');
        }

    });

// clear form data button
    $(function() {
        $('#reset').click(function(e) {
            $(':input','#form-horizontal')
                .not(':button, :submit, :reset, :hidden')
                .val('')
                .removeAttr('checked')
                .removeAttr('selected');
                return false;
        });
    });








    var counter = 2;

    $("#add_request").click(function () {

        if(counter>10){
            alert("Only 10 allowed");
            return false;
        }

        var newTextBoxDiv = $(document.createElement('div'))
            .attr("id", 'request_' + counter);


        newTextBoxDiv.after().load("html/request_inner.html",function() {
            $("#nav nav-tabs").find("href").each(function() {
                alert("test");
            });
        });

        newTextBoxDiv.appendTo("#request_group");


        counter++;
    });

    $("#remove_request").click(function () {
        if(counter===2){
            alert("No more to remove");
            return false;
        }

        counter--;

        $("#request_" + counter).remove();

    });


};




