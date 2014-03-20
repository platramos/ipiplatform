When(/^I navigate to the create new journey page$/) do
  @new_journey_page = NewJourneyPage.new
  @edit_value_proposition_page.new_journey.click
end

When(/^I create a new journey$/) do
  @journey = FactoryGirl.create
  @new_journey_page.title_field.set(@journey.title)
  @new_journey_page.submit_button.click
end

Then(/^I should be redirected to the value proposition page$/) do
  @show_value_proposition_page.should be_displayed
end

Then(/^I should see the new journey$/) do
  @show_value_proposition_page.journeys.last.should have_text(@journey.title)
end
