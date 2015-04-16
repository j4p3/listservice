// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require filterrific/filterrific-jquery

$(document).on('ready page:load', function () {
  window.disqus_rails = new DisqusRails({"short_name":"listservicetest","public_key":"Xitrb3e3FNzRTQ84ruC0YBD35uEVU3prS1EMGM3VDNoVnG6bjbPMKhTo63KTF89H"});
  $(document).trigger('disqus.load');
})

$(function() {
  if ($('#infinite-scrolling').size() > 0) {
    $(window).on('scroll', function() {
      var more_posts_url;
      more_posts_url = $('.pagination a[rel=next]').attr('href');
      if (more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60) {
        $('.pagination').html("");
        $.ajax({
          url: more_posts_url,
          success: function(data) {
            $("#posts").append($(data).find('#posts').html());
            $('#infinite-scrolling').append($(data).find('#infinite-scrolling').html());
          }
        });
      }
      if (!more_posts_url) {
        return $('.pagination').html("");
      }
    });
  }
});