class NewJourneyPage < SitePrism::Page
  set_url "/value_propositions{/value_proposition_id}/journeys/new"

  element "title_field", "#journey_title"
  element "submit_button", "#add_journey"
end
