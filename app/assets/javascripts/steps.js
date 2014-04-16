$('document').ready(function() {
  $('#step-form').hide();

  $('#step-btn').click(function(){
    if($('#step-form').is(':hidden')){
      $('#step-form').slideDown('slow');
    }
    else{
      $('#step-form').slideUp('slow');
    }
  });
});
