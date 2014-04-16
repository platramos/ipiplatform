$('document').ready(function() {
  $('#step-form').hide();

  $('#step-btn').click(function(){
    if($('#step-form').is(':hidden')){
      $('#step-form').slideDown('slow');
      $('.add-step').text('Done Adding Step');
    }
    else{
      $('#step-form').slideUp('slow');
      $('.add-step').text('Edit Step');
    }
  });
});

