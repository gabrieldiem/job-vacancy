require 'spec_helper'
require_relative '../../models/offers_limit_exceeded_exception'

describe User do
  subject(:user) { described_class.new({}) }

  let(:on_demand_subscription) { 0 }
  let(:non_profit_subscription) { 1 }

  describe 'model' do
    it { is_expected.to respond_to(:id) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:crypted_password) }
    it { is_expected.to respond_to(:email) }
  end

  describe 'valid?' do
    it 'should be false when name is blank' do
      user = described_class.new(email: 'john.doe@someplace.com',
                                 crypted_password: 'a_secure_passWord!')
      expect(user.valid?).to eq false
      expect(user.errors).to have_key(:name)
    end

    it 'should be false when email is not valid' do
      user = described_class.new(name: 'John Doe', email: 'john',
                                 crypted_password: 'a_secure_passWord!')
      expect(user.valid?).to eq false
      expect(user.errors).to have_key(:email)
    end

    it 'should be false when password is blank' do
      user = described_class.new(name: 'John Doe', email: 'john')
      expect(user.valid?).to eq false
      expect(user.errors).to have_key(:crypted_password)
    end

    it 'should be true when all field are valid' do
      user = described_class.new(name: 'John Doe', email: 'john@doe.com',
                                 crypted_password: 'a_secure_passWord!')
      expect(user.valid?).to eq true
    end
  end

  describe 'has password?' do
    let(:password) { 'password' }
    let(:user) do
      described_class.new(password:,
                          email: 'john.doe@someplace.com',
                          name: 'john doe')
    end

    it 'should return false when password do not match' do
      expect(user).not_to have_password('invalid')
    end

    it 'should return true when password do  match' do
      expect(user).to have_password(password)
    end
  end

  it 'User with OnDemandSubscription and 1 active offer has a bill of 10.0' do
    offers = [JobOffer.new(title: 'a title', salary: 0, is_active: true)]

    expect(user.billed_amount(offers)).to eq 10.0
  end

  it 'User with OnDemandSubscription and 2 active offer has a bill of 20.0' do
    offers = []
    2.times do
      offers.push JobOffer.new(title: 'a title', salary: 0, is_active: true)
    end

    expect(user.billed_amount(offers)).to eq 20.0
  end

  it 'User with example@org.com and non-profit subscription and 2 active offer has a bill of 0.0' do
    user = described_class.new(name: 'juan',
                               email: 'example@ngo.org',
                               password: 'password',
                               subscription_type: non_profit_subscription)
    offers = []
    2.times do
      offers.push JobOffer.new(title: 'a title', salary: 0, is_active: true)
    end

    expect(user.billed_amount(offers)).to eq 0.0
  end

  it 'User with example@ngo.org and non-profit subscription and 2 active and 1 inactive offer has a bill of 0.0' do
    user = described_class.new(name: 'juan',
                               email: 'example@ngo.org',
                               password: 'password',
                               subscription_type: non_profit_subscription)
    offers = []
    2.times do
      offers.push JobOffer.new(title: 'a title', salary: 0, is_active: true)
    end

    offers.push JobOffer.new(title: 'a title', salary: 0, is_active: false)

    expect(user.billed_amount(offers)).to eq 0.0
  end

  xit 'User with non-profit subscription and 7 active and 1 inactive offer should not be able to active the 8th' do
    user = described_class.new(name: 'juan',
                               email: 'example@ngo.org',
                               password: 'password',
                               subscription_type: non_profit_subscription)
    user_offers = []
    7.times do
      user_offers.push JobOffer.new(title: 'a title', salary: 0, is_active: true)
    end
    repo = instance_double('offer_repo', find_by_owner: user_offers)

    target = JobOffer.new(title: 'a title', salary: 0, is_active: false)
    target.owner = user

    offer_counter = OfferCounter.new(repo)
    expect { target.activate(offer_counter.count_active_by_user(user)) }.to raise_error OffersLimitExceededException
  end

  xit 'User with OnDemandSubscription and 10 active offers has allowance' do
    user = described_class.new(name: 'juan',
                               email: 'example@ngo.org',
                               password: 'password',
                               subscription_type: on_demand_subscription)
    active_offers_count = 10
    expect(user.subscription_has_allowance?(active_offers_count)).to be true
  end
end
