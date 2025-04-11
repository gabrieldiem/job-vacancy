require 'spec_helper'

describe SubscriptionFactory do
  let(:on_demand_type) { 0 }
  let(:non_profit_org_type) { 1 }
  let(:an_email) { 'a@example.com' }

  it 'Creates an OnDemandSubscription for its type' do
    factory = described_class.new
    subscription = factory.create_subscription(on_demand_type, an_email)
    expect(subscription.is_a?(OnDemandSubscription)).to be true
  end
end
