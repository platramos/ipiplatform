Feature: Create account and log in as a user

  Background:
    Given a user account exists
    And a second user account exists


  @omniauth_test
  Scenario: User can create an account
    Given I am on the homepage
    When I go to create an account
    And I fill in all required account fields
    Then I should have access to my user profile


  @omniauth_test
  Scenario: User can log in
    When I login as a user
    Then I should have access to my user profile


  @omniauth_test
  Scenario: User can log out
    And I login as a user
    When I go to log out
    Then I should not have access to my user profile


  @omniauth_test
  Scenario: User cannot view other users' accounts by changing url
    Given I login as a user
    When I change the url to user 2 profile page
    Then an authorization error message is displayed
    And I should be on the homepage


  @omniauth_test
  Scenario: A user logging in from the homepage is returned there
    Given I am on the homepage
    When I login as a user
    Then I should be on the homepage

   @wip
   @omniauth_test
   Scenario: A user logging in from the value proposition category index page is returned there
    Given I go to the general value proposition category index page
    When I login as an user
    Then I should be on the general value proposition category index page
