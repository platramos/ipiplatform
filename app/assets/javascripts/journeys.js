$('document').ready(function() {
  var $newJourney = $('#new-journey');
  var $journeyForm = $('#journey-form');
  var $newJourneyBtn = $('#new-journey-btn');
  var $journeyBtn = $('#journey-btn');

  $newJourney.hide();
  $journeyForm.hide();

  $newJourneyBtn.click(function(){
    $newJourney.slideDown('slow');
    $newJourneyBtn.attr('disabled', 'disabled');
  });

  $journeyBtn.click(function(){
    if($journeyForm.is(':hidden')){
      $journeyForm.slideDown('slow');
      $journeyBtn.text('Done Adding Journey Title');
    }
    else{
      $journeyForm.slideUp('slow');
      $journeyBtn.text('Edit Journey Title');
    }
  });

});
