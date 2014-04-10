Feature: Deleting an existing value proposition category as an admin

  Background:
    Given an admin account exists
    And I login as an admin
    And a value proposition category and a value proposition exist

  @javascript
  @omniauth_test
  Scenario:  Admin can delete an existing value proposition category
    When I visit the admin profile page
    And I go to manage value proposition categories
    And I go to edit an existing value proposition category
    And I delete the value proposition category
    When I go to the general value proposition category index page
    Then I should not see the value proposition category
