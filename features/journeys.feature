Feature: Creating a journey
  Background:
    Given an admin account exists
    And I login as an admin
    And a value proposition exists
    And I go to the edit value proposition page for the value proposition

  @omniauth_test
  Scenario: Creating a new journey
    When I navigate to the create new journey page
    And I create a new journey
    Then I should be redirected to the edit value proposition page
    And I should see the new journey


