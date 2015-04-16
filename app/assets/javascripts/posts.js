// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require filterrific/filterrific-jquery

$(document).on('ready page:load', function () {
  window.disqus_rails = new DisqusRails({"short_name":"listservicetest","public_key":"Xitrb3e3FNzRTQ84ruC0YBD35uEVU3prS1EMGM3VDNoVnG6bjbPMKhTo63KTF89H"});
  $(document).trigger('disqus.load');
})
