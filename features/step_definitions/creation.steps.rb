Given(/^a user account exists$/) do
  @user = FactoryGirl.create(:user)
end

Given(/^an admin account exists$/) do
  @admin = FactoryGirl.create(:user, :admin)
end

Given(/^a second user account exists$/) do
  @user2 = FactoryGirl.create(:user)
end

Given(/^the user creates a resource$/) do
  @step = @step || FactoryGirl.create(:step)
  @resource = FactoryGirl.create(:resource, user_id: @user.id, step_ids: [@step.id])
end

Given(/^the admin creates a resource$/) do
  @step = @step || FactoryGirl.Create(:step)
  @resource = FactoryGirl.create(:resource, user_id: @admin.id, step_ids: [@step.id])
end
Given(/^the second user creates a resource$/) do
  @step = @step || FactoryGirl.create(:step)
  @resource2 = FactoryGirl.create(:resource, user_id: @user2.id, step_ids: [@step.id])
end

Given(/^a value proposition category exists$/) do
  @value_proposition_category = FactoryGirl.create(:value_proposition_category)
end

Given(/^a value proposition exists$/) do
  @value_proposition = FactoryGirl.create(:value_proposition)
end

Given(/^a journey exists$/) do
  @journey = FactoryGirl.create(:journey, value_proposition_id: @value_proposition.id)
end

Given(/^a step exists$/) do
  @step = FactoryGirl.create(:step)
end

Given(/^a step exists for the last journey$/) do
  @step = FactoryGirl.create(:step, journey_id: @journey.id)
end

Given(/^a value proposition category and a value proposition exist$/) do
  @value_proposition_category = FactoryGirl.create(:value_proposition_category)
  @value_proposition = FactoryGirl.create(:value_proposition, value_proposition_category: @value_proposition_category)
end

Given(/^a resource exists$/) do
  @resource = FactoryGirl.create(:resource)
end

Given(/^two more resources exist/) do
  @resource2 = FactoryGirl.create(:resource, name: 'a second resource')
  @resource3 = FactoryGirl.create(:resource, name: 'a third resource')
end

Given(/^a resource with a (.*?) value proposition exists$/) do |value_proposition_name|
  @value_proposition = FactoryGirl.create(:value_proposition, name: value_proposition_name)
  @resource = FactoryGirl.create(:resource)
  @resource.value_propositions << @value_proposition
end

Given(/^a resource exists for the last step$/) do
  @resource = FactoryGirl.create(:resource, steps: [Step.last])
end

private

def create_user_type(user_type)
  if user_type == "admin" && @admin.present?
    return @admin
  else
    return @user
  end
end
