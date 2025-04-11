require 'spec_helper'

describe OnDemandSubscription do
  it 'Cost of 1 offers is 10' do
    subscription = described_class.new
    expect(subscription.calculate_cost([JobOffer.new(title: 'a title', salary: 0)])).to eq 10
  end
end
