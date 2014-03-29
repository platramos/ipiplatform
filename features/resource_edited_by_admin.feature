Feature: Admin Edits any Resource

  Background:
    Given an admin account exists
    And I login as an admin
    And a value proposition exists
    And a journey exists
    And a step exists for the last journey
    And the admin creates a resource
    And I am on the edit step page

  Scenario: An admin can edit a resource from the edit step page
    When I select the resource to edit
    And I edit the resource name
    And I submit the resource
    Then I should see the edited resource name
