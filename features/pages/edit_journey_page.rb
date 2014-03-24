class EditJourneyPage < SitePrism::Page
  set_url "value_propositions{/id}/journeys{/id}/edit"
  set_url_matcher /\/value_propositions\/\d+\/journeys\/\d+\/edit/

  element "title_field", "#journey_title"
  element "submit_button", "#edit_journey"
end
