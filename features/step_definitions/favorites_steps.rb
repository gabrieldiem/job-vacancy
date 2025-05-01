Given('a job offer exists created by a job offerer') do
  @user_repository = UserRepository.new
  @job_offer_repository = JobOfferRepository.new

  @user_password = 'somePassword'
  @user_offerer = User.new(name: 'user', email: 'user@gmail.org', password: @user_password,
                           subscription_type: SUBSCRIPTION_TYPE_ON_DEMAND, birthdate: Date.new(1990, 10, 25),
                           current_date: Date.new(2025, 10, 1))
  @user_repository.save(@user_offerer)

  @job_offer = JobOffer.new(title: 'Software Engineer', user_id: @user_offerer.id, salary: 0, is_active: true)
  @job_offer_repository.save(@job_offer)
end

Given('I am logged in as a registered user') do
  @user_applicant = User.new(name: 'applicant', email: 'applicant@gmail.org', password: 'password1234',
                             subscription_type: SUBSCRIPTION_TYPE_ON_DEMAND, birthdate: Date.new(1990, 10, 25),
                             current_date: Date.new(2025, 10, 1))
  @user_repository.save(@user_applicant)
  visit '/login'
  fill_in('user[email]', with: 'applicant@gmail.org')
  fill_in('user[password]', with: 'password1234')
  click_button('Login')
end

Given('I have active job offers') do
  @job_offer = JobOffer.new(title: 'Frontend Developer', user_id: @user_applicant.id, salary: 0, is_active: true)
  @job_offer_repository.save(@job_offer)
end

When('I visit the job offers page') do
  visit '/job_offers'
end

Then('I see the message {string}') do |message|
  page.should have_content(message)
end

Given('I marked the job offer {string} as favorite') do |title|
  visit '/job_offers'
  @title = title
  within(:xpath, "//tr[td[contains(text(), '#{title}')]]") do
    find("a[name='Favorite']").click
  end
end

When('I click the button to mark as favourite') do
  within(:xpath, "//tr[td[contains(text(), '#{@title}')]]") do
    find("a[name='Favorite']").click
  end
end

Given('I am logged in as a job offerer') do
  visit '/login'
  fill_in('user[email]', with: 'applicant@gmail.org')
  fill_in('user[password]', with: 'password1234')
  click_button('Login')
end

When('I click the button to mark as favourite on my own job offer') do
  within(:xpath, "//tr[td[contains(text(), 'Frontend Developer')]]") do
    find("a[name='Favorite']").click
  end
end

Then('I should not see the message {string}') do |message|
  page.should_not have_content(message)
end

Given('I am not logged in') do
  visit '/logout'
end

Then('I do not see the button to mark as favourite for the offers') do
  visit '/job_offers'
  page.should_not have_content('Favorites')
end

Given('I have marked one job offer as favorite') do
  pending # Write code here that turns the phrase above into concrete actions
end

When('I click the {string} button') do |_string|
  pending # Write code here that turns the phrase above into concrete actions
end

Given('I am logged in a job offerer') do
  pending # Write code here that turns the phrase above into concrete actions
end

Given('{int} users have marked my job offer as favorite') do |number_of_favorites|
  job_offer = @job_offer_repository.find_by_owner(@user_applicant).first
  @favorites_repository = FavoriteRepository.new

  number_of_favorites.times do
    favorite = Favorite.new(user: @user_offerer, job_offer:)
    @favorites_repository.save(favorite)
  end
end

When('I visit my job offers page') do
  visit '/job_offers/my'
end

Then('I see {string} for that job offer') do |string_number_of_favorites|
  page.should have_content(string_number_of_favorites)
end
