$('document').ready(function() {
  $('#resource-form').hide();

  $('#resource-btn').click(function(){
    if($('#resource-form').is(':hidden')){
      $('#resource-form').slideDown('slow');
      $('#resource-btn').text('Done Adding Resource');
    }
    else{
      $('#resource-form').slideUp('slow');
      $('#resource-btn').text('Edit Resource');
    }
  });
});
