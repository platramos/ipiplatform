Feature: User Viewing Resources

  Background:
    Given a user account exists
    And I login as a "user"
    And the user creates a resource

  @omniauth_test
  Scenario: Users can see all resources
    When I go to the resources index page
    Then I should see all resources

  @omniauth_test
  Scenario: Users can view a specific resource
    When I go to the resources index page
    And I go to my resource's show page
    Then I should see details about the resource
