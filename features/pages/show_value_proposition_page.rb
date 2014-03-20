class ShowValuePropositionPage < SitePrism::Page
  set_url "/value_propositions{/id}"

  elements "steps", ".vp_steps"

  elements "resources", ".step_resources"
  elements "journeys", ".vp_journeys"
end
