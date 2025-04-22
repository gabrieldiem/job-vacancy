Given('I am in the register page') do
  visit '/register'
end

Given('I press the button to see the subscription types') do
end

Then('I should be able to see all of the subscription types available') do
  expect(page).to have_select('user[subscription_type]', options: ['On demand', 'Non-commercial organization'])
end

Given('I fill the registration form and I select the subscription type “on-demand”') do
  pending # Write code here that turns the phrase above into concrete actions
end

When('I press the Register button') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see the subscription type under my email') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I fill the registration form and don’t select a subscription') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see the error message “can’t be blank”') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I fill the registration form and I select the subscription type “non-profit organization”') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('email is “example@place.org”') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('email is “example@place.com”') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see the error message “must have .org mail for non commercial organization subscription”') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I have a “non-profit organization” subscription with email “example@place.org”') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('add {int} active job offers') do |_int|
  # Given('add {float} active job offers') do |float|
  pending # Write code here that turns the phrase above into concrete actions
end

When('I press the button to activate the 8th active job offer') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see the error message “limit exceeded for non commercial organization subscription. Max is {int} active offers”') do |_int|
  # Then('I should see the error message “limit exceeded for non commercial organization subscription. Max is {float} active offers”') do |float|
  pending # Write code here that turns the phrase above into concrete actions
end
