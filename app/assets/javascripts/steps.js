$('document').ready(function() {
  $('#step-form').hide();

  $('#step-btn').click(function(){
    if($('#step-form').is(':hidden')){
      $('#step-form').slideDown('slow');
      $('#step-btn').text('Done Adding Step');
    }
    else{
      $('#step-form').slideUp('slow');
      $('#step-btn').text('Edit Step');
    }
  });

  $('.add-new-step').click(function(){
    var stepForm = $('.add-step').clone();
    $('#resource-form').append(stepForm);
  });
});

