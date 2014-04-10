Feature: Editing an existing value proposition category as an admin

  Background:
    Given an admin account exists
    And I login as an admin
    And a value proposition category exists

  @javascript
  @omniauth_test
  Scenario:  Admin can edit an existing value proposition category
    When I visit the admin profile page
    And I go to manage value proposition categories
    And I go to edit an existing value proposition category
    And I change the name of the value proposition category
    And I save the edited value proposition category
    Then I should see the value proposition category has been edited
