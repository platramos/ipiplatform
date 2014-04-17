$('document').ready(function() {
  var $stepForm = $('#step-form');
  var $resourceBtn = $('#resource-btn');
  var $stepBtn = $('#step-btn');
  var $resourceForm = $('#resource-form');
  var $addAnotherStep = $('#add-another-step');


  $stepForm.hide();
  $resourceBtn.hide();

  $stepBtn.click(function(){
    if($stepForm.is(':hidden')){
      $stepForm.slideDown('slow');
      $resourceBtn.slideDown('slow');
      $stepBtn.text('Done Adding Step');
    }
    else{
      $stepForm.slideUp('slow');
      $resourceBtn.slideUp('slow');
      $resourceForm.slideUp('slow');
      $stepBtn.text('Edit Step');
    }
  });

    id = 0;
  $addAnotherStep.click(function(){
    var stepForm = $('#step-form.add-step').clone().attr('id', "step-form-" + id);
    $addAnotherStep.before(stepForm);
    id++;
  });
});

