$('document').ready(function() {
  $('#step-form').hide();
  $('#resource-btn').hide();

  $('#step-btn').click(function(){
    if($('#step-form').is(':hidden')){
      $('#step-form').slideDown('slow');
      $('#resource-btn').slideDown('slow');
      $('#step-btn').text('Done Adding Step');
    }
    else{
      $('#step-form').slideUp('slow');
      $('#resource-btn').slideUp('slow');
      $('#resource-form').slideUp('slow');
      $('#step-btn').text('Edit Step');
    }
  });

  $('.add-new-step').click(function(){
    var stepForm = $('.add-step').clone();
    $('#step-btn').after(stepForm);
  });
});

