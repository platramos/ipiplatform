Feature: Adding existing resources to steps as an admin
  Background:
    Given an admin account exists
    And I login as an admin
    And a value proposition exists
    And a journey exists
    And a step exists for the last journey
    And a resource exists
    And I am on the edit step page

  @omniauth_test
  Scenario: Adding one existing resource to a step
    When I navigate to the add existing resource page
    And I add one resource to that step
    Then I should be redirected to the edit step page
    And I should see the resource

  @omniauth_test
  Scenario: Adding two existing resources to a step
    Given two more resources exist
    And I am on the edit step page
    When I navigate to the add existing resource page
    And I add two resources to that step
    Then I should be redirected to the edit step page
    And I should see the two resources

