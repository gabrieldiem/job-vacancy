require 'spec_helper'

describe NonProfitOrganizationSubscription do
  let(:org_email) { 'example@org.com' }

  it 'Cost of 1 active offers is 0.0' do
    subscription = described_class.new org_email
    expect(subscription.calculate_cost([JobOffer.new(title: 'a title', salary: 0, is_active: true)])).to eq 0.0
  end
end
