require 'json'

Given('there are no offers at all') do
  JobOfferRepository.new.delete_all
end

When('I get the billing report') do
  visit 'reports/billing'
  @report_as_json = JSON.parse(page.body)
end

Then('the total active offers is {int}') do |expected_active_offers|
  expect(@report_as_json['total_active_offers']).to eq expected_active_offers
end

Then('the total amount is {float}') do |expected_total_amount|
  expect(@report_as_json['total_amount']).to eq expected_total_amount
end

Given('a user {string} with {string} subscription') do |user_email, _subscription_type|
  @user = User.create(user_email, user_email, 'somePassword!')
  UserRepository.new.save(@user)
end

Given('{int} active offers') do |offer_count|
  JobOfferRepository.new.delete_all if offer_count.zero?
end

require 'debug'

Then('the amount to pay for the user {string} is {float}') do |user_email, expected_amount|
  target = nil

  @report_as_json['items'].each do |user_info|
    target = user_info if user_info['user_email'] == user_email
  end

  expect(target).to_not be_nil
  expect(target['user_email']).to eq user_email
  expect(target['amount_to_pay']).to eq expected_amount
end

Then('the total active offers are {int}') do |_expected_offer_count|
  pending # Write code here that turns the phrase above into concrete actions
end

Given('another user {string} with {string} susbcription') do |_user_email, _subscription_type|
  pending # Write code here that turns the phrase above into concrete actions
end

Given('the user {string} has {int} active offers') do |user_email, active_offer_count|
  user_repo = UserRepository.new
  job_offer_repo = JobOfferRepository.new
  owner = user_repo.find_by_email user_email

  active_offer_count.times do
    job_offer_repo.save JobOffer.new(title: 'a title', user_id: owner.id, salary: 0)
  end
end

Given('{int} inactive offers') do |_inactive_offer_count|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('the billing for this user is {float}') do |_expected_amount|
  pending # Write code here that turns the phrase above into concrete actions
end

Given('the user {string}') do |_user_email|
  pending # Write code here that turns the phrase above into concrete actions
end

Given('another user with {string} susbcription') do |_subscription_type|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('the amount to pay for the user {string} is {float}.') do |_user_email, _expected_amount|
  pending # Write code here that turns the phrase above into concrete actions
end
