$('document').ready(function() {
  $('#step_name').hide();
  $('#step-description').hide();

  $('#step-btn').click(function(){
    $('#step_name').slideDown("slow");
    $('#step-description').slideDown("slow");
  });
});
