Given('I am in the register page') do
  visit '/register'
end

Given('I press the button to see the subscription types') do
end

Then('I should be able to see all of the subscription types available') do
  expect(page).to have_select('user[subscription_type]', options: ['On demand', 'Non-commercial organization'])
end

Given('I fill the registration form and I select the subscription type {string} and email is {string}') do |subscription_type, email|
  @user_email = email
  @user_password = 'abc'
  @user_subscription_type = subscription_type

  fill_in('user[name]', with: 'Pepe')
  fill_in('user[email]', with: @user_email)
  fill_in('user[password]', with: @user_password)
  fill_in('user[password_confirmation]', with: @user_password)
  select @user_subscription_type, from: 'user[subscription_type]'
end

When('I press the Register button') do
  click_button('Create')
end

Then('I should see the subscription type under my email') do
  visit '/login'
  fill_in('user[email]', with: @user_email)
  fill_in('user[password]', with: @user_password)
  click_button('Login')
  page.should have_content(@user_subscription_type)
end

Given('I fill the registration form and don’t select a subscription') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('email is “example@place.org”') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('email is “example@place.com”') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see the error message {string}') do |error_message|
  page.should have_content(error_message)
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
