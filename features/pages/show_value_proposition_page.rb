class ShowValuePropositionPage < SitePrism::Page
  set_url "/value_propositions{/id}"
  set_url_matcher /\/value_propositions\/\d+/

  elements "steps", ".vp_steps"

  elements "resources", ".step_resources"
  elements "journeys", ".vp_journeys"
end
