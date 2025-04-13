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

Given('a user {string} with {string} subscription') do |user_email, subscription_type_string|
  subscription_type = case subscription_type_string
                      when 'on-demand'
                        0
                      else
                        1
                      end

  @user = User.new(name: user_email, email: user_email, password: 'somePassword!', subscription_type:)
  UserRepository.new.save(@user)
end

Given('{int} active offers') do |offer_count|
  JobOfferRepository.new.delete_all if offer_count.zero?
  job_offer_repo = JobOfferRepository.new

  offer_count.times do
    job_offer_repo.save JobOffer.new(title: 'a title', user_id: @user.id, salary: 0, is_active: true)
  end
end

Then('the amount to pay for the user {string} is {float}') do |user_email, expected_amount|
  target = nil

  @report_as_json['items'].each do |user_info|
    target = user_info if user_info['user_email'] == user_email
  end

  expect(target).to_not be_nil
  expect(target['user_email']).to eq user_email
  expect(target['amount_to_pay']).to eq expected_amount
end

Then('the total active offers are {int}') do |expected_offer_count|
  expect(@report_as_json['total_active_offers']).to eq expected_offer_count
end

Given('another user {string} with {string} susbcription') do |user_email, _subscription_type|
  @user = User.new(name: user_email, email: user_email, password: 'somePassword!')
  UserRepository.new.save(@user)
end

Given('the user {string} has {int} active offers') do |user_email, active_offer_count|
  user_repo = UserRepository.new
  job_offer_repo = JobOfferRepository.new
  owner = user_repo.find_by_email user_email

  active_offer_count.times do
    job_offer_repo.save JobOffer.new(title: 'a title', user_id: owner.id, salary: 0, is_active: true)
  end
end

Given('{int} inactive offers') do |inactive_offer_count|
  job_offer_repo = JobOfferRepository.new

  inactive_offer_count.times do
    job_offer_repo.save JobOffer.new(title: 'a title', user_id: @user.id, salary: 0, is_active: false)
  end
end

Then('the billing for this user is {float}') do |expected_amount|
  target = nil

  @report_as_json['items'].each do |user_info|
    target = user_info if user_info['user_email'] == @user.email
  end

  expect(target).to_not be_nil
  expect(target['user_email']).to eq @user.email
  expect(target['amount_to_pay']).to eq expected_amount
end

Given('the user {string}') do |user_email|
end

Given('another user with {string} susbcription') do |_subscription_type|
  @user = User.new(name: 'name', email: 'mail@mail.com', password: 'somePassword!')
  UserRepository.new.save(@user)
end

Then('the amount to pay for the user {string} is {float}.') do |_user_email, _expected_amount|
  pending # Write code here that turns the phrase above into concrete actions
end

When('I try to activate 1 more offer I receive an error') do
  job_offer_repo = JobOfferRepository.new
  job_offers = job_offer_repo.find_by_owner @user
  target = nil
  job_offers.each do |offer|
    target = offer unless offer.is_active?
  end

  offer_counter = OfferCounter.new(job_offer_repo)
  expect(target).to_not be_nil
  expect do
    target.activate(offer_counter.count_active_by_user(@user))
  end.to raise_error OffersLimitExceededException
end

Given('a user with email {string}') do |user_email|
  @non_org_email = user_email
end

Then('I should not be able to create a non-profit organization subscription') do
  expect do
    User.new(name: 'name', email: @non_org_email, password: 'somePassword!', subscription_type: 1)
  end.to raise_error InvalidEmailForNonProfitOrganizationSubscriptionException
end

Then('{string} is on user_email report field') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('the subscription is {string}') do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('the active_offers_count is {int}') do |int|
  pending # Write code here that turns the phrase above into concrete actions
end

Then('the amount to pay is {float}') do |float|
  pending # Write code here that turns the phrase above into concrete actions
end
