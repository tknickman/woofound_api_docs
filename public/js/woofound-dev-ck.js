window.onload=function(){$(document).on("input","#username",function(){$("#username_curl").html(this.value)});$(document).on("input","#password",function(){$("#password_curl").html(this.value)});$(document).on("input","#app_secret",function(){$("#app_secret_curl").html(this.value)});$(document).on("input","#id",function(){$("#endpoint_curl").html(this.value)});$("#dropdown").change(function(){$("#textBoxContainer").empty();var e=$(this).find("option:selected").attr("value"),t=e.split("_"),n=t.length;for(var r=0;r<n;r++)$("#textBoxContainer").append('<label class="control-label" for="textinput">'+t[r]+'</label><br/><input id="'+t[r]+'" name="textinput" size="25" type="text" placeholder="'+t[r]+'" class="input-xlarge"><br/>')})};