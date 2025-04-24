Given('the current date is {string}') do |date_string|
  @current_date = Date.strptime(date_string, '%Y/%m/%d')
  allow(Date).to receive(:today).and_return(@current_date)
end

Given('the format is YYYY\/MM\/DD') do
  @date_format = '%Y/%m/%d'
end

Given('I register with a birthdate of {string}') do |date|
  visit '/register'

  @user_name = 'Pepe'
  @user_email = 'test@test.com'
  @user_password = 'abc'
  @user_subscription_type = 'On demand'

  fill_in('user[name]', with: @user_name)
  fill_in('user[email]', with: @user_email)
  fill_in('user[birthdate]', with: date)
  fill_in('user[password]', with: @user_password)
  fill_in('user[password_confirmation]', with: @user_password)
  select @user_subscription_type, from: 'user[subscription_type]'
  click_button('Create')
end

Then('I should be able to complete the registration successfully') do
  page.should have_content('User created')
end
