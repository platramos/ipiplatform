Feature: Editing a journey
  Background:
    Given an admin account exists
    And a value proposition exists
    And a journey exists
    And I login as an admin
    And I go to the edit value proposition page for the value proposition

  Scenario: Editing a journey
    When I navigate to the edit journey page
    And I change the title of that journey
    Then I should be redirected to the value proposition page
    And I should see the new journey title
