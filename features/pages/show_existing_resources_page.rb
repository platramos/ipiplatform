class ShowExistingResourcesPage < SitePrism::Page
  set_url "resources/show_existing_resources{/step_id}"

  element "add_resource_links", "#add_resource"
end
