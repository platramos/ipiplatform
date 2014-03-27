When(/^I navigate to the create new journey page$/) do
  @new_journey_page = NewJourneyPage.new
  @edit_value_proposition_page.new_journey.click
end

When(/^I create a new journey$/) do
  @new_journey_page.title_field.set("jTitle")
  @new_journey_page.submit_button.click
end

Then(/^I should be redirected to the edit value proposition page$/) do
  @edit_value_proposition_page.should be_displayed
end

Then(/^I should see the new journey$/) do
  @edit_value_proposition_page.journeys.last.should have_text("jTitle")
end

When(/^I navigate to the edit journey page$/) do
  @edit_journey_page = EditJourneyPage.new
  @edit_value_proposition_page.edit_journey.first.click
end

When(/^I change the title of that journey$/) do
  @edit_journey_page.title_field.set("changedTitle")
  @edit_journey_page.submit_button.click
end

Then(/^I should see the new journey title$/) do
  @show_value_proposition_page.journeys.first.should have_text("changedTitle")
end

