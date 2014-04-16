$('document').ready(function() {
  $('#new-journey').hide();
  $('#journey-form').hide();

  $('#new-journey-btn').click(function(){
    $('#new-journey').slideDown('slow');
    $('#new-journey-btn').attr('disabled', 'disabled');
  });

  $('#journey-btn').click(function(){
    if($('#journey-form').is(':hidden')){
      $('#journey-form').slideDown('slow');
      $('#journey-btn').text('Done Adding Journey Title');
    }
    else{
      $('#journey-form').slideUp('slow');
      $('#journey-btn').text('Edit Journey Title');
    }
  });

});
