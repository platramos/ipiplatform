Feature: Uploading an image to a resource

Background:
  Given a user account exists
  Given I login as a user
  Given a step exists
  Given I am on the add resource page for the last step 
  Given I fill in required resource fields

@javascript
@omniauth_test
Scenario: User successfully uploads an image to a resource
  When I upload the image to the image upload
  When I submit the resource
  When I navigate to the last resource show page
  Then the uploaded image should be displayed

