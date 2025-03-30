SALARY_FIELD_REQUIRED_ERROR_MESSAGE = "can't be blank".freeze

When('I create a new offer with title {string}, location {string}, description {string} and salary {string}') do
|title, location, description, salary|
  visit '/job_offers/new'
  fill_in('job_offer_form[title]', with: title)
  fill_in('job_offer_form[location]', with: location)
  fill_in('job_offer_form[description]', with: description)
  fill_in('job_offer_form[salary]', with: salary)
  click_button('Create')
end

Then('I should see a title {string} in my offers list') do |title|
  visit '/job_offers/my'
  page.should have_content(title)
end

And('the location should be {string}') do |location|
  visit '/job_offers/my'
  page.should have_content(location)
end

And('the description should be {string}') do |description|
  visit '/job_offers/my'
  page.should have_content(description)
end

And('the salary should be {string}') do |salary|
  visit '/job_offers/my'
  page.should have_content(salary)
end

Then('I should see an offer error message asking to fill in the salary') do
  page.should have_content(SALARY_FIELD_REQUIRED_ERROR_MESSAGE)
end

Then('I activate the job offer') do
  visit '/job_offers/my'
  click_button('Activate')
end

Then('I should see a title {string} in the offers list with location {string}, description {string} and salary {string}') do
|title, location, description, salary|
  visit '/job_offers'
  page.should have_content(title)
  page.should have_content(location)
  page.should have_content(description)
  page.should have_content(salary)
end
