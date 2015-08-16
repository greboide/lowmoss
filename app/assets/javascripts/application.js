// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require foundation
//= require smart_listing
//= require gritter
//= require_tree .

$(function() {
    $.myapp = {};
    $(document).foundation('dropdown', 'reflow');
    $(document).foundation();
    if ($("#post_ids").length)
    {
    $.myapp.allPostIds = $.parseJSON($('#post_ids').attr('data-post-ids'));
    $.myapp.allPostIds.forEach( function(item) {
        $("#reply_to_" + item).click(function() {
            $('html, body').animate({
                scrollTop: $("#comments_form_"+ item).offset().top - 300
            }, 1500,  function(){
                $("#comments_form_" + item + " form div div textarea").focus();

            });
        });
    });
    };
});
