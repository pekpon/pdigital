// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery

//= require jquery_ujs
//= require twitter/bootstrap
//= require bootstrap.js
// require_tree .



$(document).ready(function(){
	$('.btn-close').tooltip({
		placement:'bottom'
	});
});

function show_delete_comment(id)
{
	$('#comment_'+id+' .delete').show();
}
function hide_delete_comment(id)
{
	$('#comment_'+id+' .delete').hide();
}

function show_image(id,foot)
{
	if(foot == ""){
		$('#article_image').html("<img src='"+id+"' class='article_image'>");
	}else{
		$('#article_image').html("<img src='"+id+"' class='article_image'><span id='article_foot'></span>");
		$('#article_foot').html(foot);
	}
	
}