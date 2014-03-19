class ShowExistingResourcesPage < SitePrism::Page
  set_url "resources/show_existing_resources{/step_id}"

  element "checkbox_one", "input[value='1'][type='checkbox']"
  element "checkbox_two", "input[value='2'][type='checkbox']"
  element "checkbox_three", "input[value='3'][type='checkbox']"
  element "submit_button", "#add_resource"
end
