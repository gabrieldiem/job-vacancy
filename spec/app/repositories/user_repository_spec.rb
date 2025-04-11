require 'integration_spec_helper'

describe UserRepository do
  let(:repository) { described_class.new }
  let(:non_profit_subscription) { 1 }

  it 'should find by email' do
    joe_user = User.new(name: 'Joe', email: 'joe@doe.com', crypted_password: 'secure_pwd')
    repository.save(joe_user)

    found_user = repository.find_by_email(joe_user.email)

    expect(found_user.email).to eq joe_user.email
    expect(found_user.id).to eq joe_user.id
  end

  it 'should retrieve all users' do
    initial_user_count = repository.all.size
    some_user = User.new(name: 'Joe', email: 'joe@doe.com', crypted_password: 'secure_pwd')
    repository.save(some_user)

    users = repository.all

    expect(users.size).to eq(initial_user_count + 1)
  end

  it 'User repository saves and returns correctly an user with its subscription' do
    joe_user = User.new(name: 'Joe',
                        email: 'joe@doe.org',
                        crypted_password: 'secure_pwd',
                        subscription_type: non_profit_subscription)
    repository.save(joe_user)

    offers = [JobOffer.new(
      title: 'Software Engineer',
      salary: 100_000,
      is_active: true
    )]

    found_user = repository.find_by_email(joe_user.email)
    expect(found_user.billed_amount(offers)).to eq 0.0
  end
end
