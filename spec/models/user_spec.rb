require 'spec_helper'

describe User do
  subject(:user) { described_class.new({}) }

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
end
