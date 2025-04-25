Given('I am in the register page') do
  visit '/register'
end

Then('I should be able to see all of the subscription types available') do
  expect(page).to have_select('user[subscription_type]', options: ['On demand', 'Non-commercial organization'])
end

Given('I fill the registration form and I select the subscription type {string} and email is {string}') do |subscription_type, email|
  @user_email = email
  @user_password = 'abc'
  @user_subscription_type = subscription_type

  @current_date = Date.strptime('2025/10/25', '%Y/%m/%d')
  allow(Date).to receive(:today).and_return(@current_date)

  fill_in('user[name]', with: 'Pepe')
  fill_in('user[email]', with: @user_email)
  fill_in('user[password]', with: @user_password)
  fill_in('user[birthdate]', with: '1990/10/25')
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

Then('I should see the error message {string}') do |error_message|
  page.should have_content(error_message)
end

Given('I have a {string} subscription with email {string}') do |subscription_type_string, email|
  subscription_type = case subscription_type_string
                      when 'On demand'
                        SUBSCRIPTION_TYPE_ON_DEMAND
                      else
                        SUBSCRIPTION_TYPE_NON_PROFIT_ORGANIZATION
                      end

  @user_email = email
  @user_password = 'somePassword'
  @user = User.new(name: email, email:, password: @user_password, subscription_type:, birthdate: Date.new(1990, 10, 25),
                   current_date: Date.new(2025, 10, 1))
  UserRepository.new.save(@user)
end

Given('add {int} active job offers') do |offer_count|
  JobOfferRepository.new.delete_all if offer_count.zero?
  job_offer_repo = JobOfferRepository.new

  offer_count.times do
    job_offer_repo.save JobOffer.new(title: 'a title', user_id: @user.id, salary: 0, is_active: true)
  end

  job_offer_repo.save JobOffer.new(title: 'a title', user_id: @user.id, salary: 0, is_active: false)
end

When('I press the button to activate the 8th active job offer') do
  visit '/login'
  fill_in('user[email]', with: @user_email)
  fill_in('user[password]', with: @user_password)
  click_button('Login')

  visit '/job_offers/my'
  click_button('Activate')
end
