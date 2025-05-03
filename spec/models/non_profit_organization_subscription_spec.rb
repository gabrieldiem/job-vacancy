require 'spec_helper'

describe NonProfitOrganizationSubscription do
  let(:org_email) { 'example@example.org' }

  let(:subscription_type_non_profit_organization) { 1 }

  it 'Cost of 1 active offers is 0.0' do
    subscription = described_class.new org_email
    expect(subscription.calculate_cost([JobOffer.new(title: 'a title', salary: 0, is_active: true,
                                                     experience_required: 0)])).to eq 0.0
  end

  it 'Not @org email is invalid for NonProfitOrganizationSubscription' do
    check_validation(:email, 'Email must have .org mail for non commercial organization subscription') do
      described_class.new('pepe@gmail.com')
    end
  end

  it 'NonProfitOrganization should have ID = subscription_type_non_profit_organization' do
    subscription = described_class.new org_email
    expect(subscription.id).to eq subscription_type_non_profit_organization
  end

  it 'NonProfitOrganization does not have allowance if user has 7 active offers' do
    subscription = described_class.new org_email
    active_offers = 7
    expect { subscription.has_allowance? active_offers }.to raise_error OffersLimitExceededException
  end

  it 'NonProfitOrganization has allowance if user has 6 active offers' do
    subscription = described_class.new org_email
    active_offers = 6
    expect(subscription.has_allowance?(active_offers)).to be true
  end
end
