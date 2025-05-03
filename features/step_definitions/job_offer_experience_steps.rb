When('I create a job offer with {string} years of required experience') do |experience|
  visit '/job_offers/new'
  fill_in('job_offer_form[title]', with: 'Software Engineer')
  fill_in('job_offer_form[location]', with: 'Remote')
  fill_in('job_offer_form[description]', with: 'Developing software')
  fill_in('job_offer_form[salary]', with: '50000')
  fill_in('job_offer_form[required_experience]', with: experience)
  click_button('Create')
end

Then('I should see {string} required experience in the job offers list') do |experience|
  visit '/job_offers/latest'
  first_experience = find('table#job_offers tbody tr:first-child td.experience').text
  expect(first_experience).to eq(experience)
end

Then('I should see it in my offers as well') do
  visit '/job_offers/my'
  first_experience = find('table#job_offers tbody tr:first-child td.experience').text
  expect(first_experience).to eq(experience)
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
