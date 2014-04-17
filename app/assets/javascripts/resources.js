$('document').ready(function() {
  var $resourceBtn = $('#resource-btn');
  var $resourceForm = $('#resource-form');

  $resourceForm.hide();

  $resourceBtn.click(function(){
    if($resourceForm.is(':hidden')){
      $resourceForm.slideDown('slow');
      $resourceBtn.text('Done Adding Resource');
    }
    else{
      $resourceForm.slideUp('slow');
      $resourceBtn.text('Edit Resource');
    }
  });
});
