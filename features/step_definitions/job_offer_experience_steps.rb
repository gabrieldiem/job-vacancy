When('I create and activate a job offer with {string} years of required experience') do |experience|
  visit '/job_offers/new'
  fill_in('job_offer_form[title]', with: 'Software Engineer')
  fill_in('job_offer_form[location]', with: 'Remote')
  fill_in('job_offer_form[description]', with: 'Developing software')
  fill_in('job_offer_form[salary]', with: '50000')
  fill_in('job_offer_form[experience_required]', with: experience)
  click_button('Create')

  visit '/job_offers/my'
  click_button('Activate')
end

Then('I should see {string} in required experience in the job offers list') do |experience|
  visit '/job_offers/latest'
  page.should have_content(experience)
end

Then('I should see {string} in my offers') do |experience|
  visit '/job_offers/my'
  page.should have_content(experience)
end

Then('I should see {string} in the job offers list') do |_string|
  pending # Write code here that turns the phrase above into concrete actions
end

When('I create a job offer without filling the required experience') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('I should see the error {string}') do |_string|
  pending # Write code here that turns the phrase above into concrete actions
end

Given('an existing job offer with {int} years of experience required') do |_int|
  # Given('an existing job offer with {float} years of experience required') do |float|
  pending # Write code here that turns the phrase above into concrete actions
end

When('I edit the job offer and change the experience to {string} years') do |_string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('the job offer should now show {string}') do |_string|
  pending # Write code here that turns the phrase above into concrete actions
end
