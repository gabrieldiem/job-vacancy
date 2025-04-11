require 'spec_helper'

describe OnDemandSubscription do
  it 'Cost of 1 offers is 10' do
    subscription = described_class.new
    expect(subscription.calculate_cost([JobOffer.new(title: 'a title', salary: 0)])).to eq 10
  end

  it 'Cost of 2 offers is 20' do
    offers = []

    2.times do
      offers.push JobOffer.new(title: 'a title', salary: 0)
    end

    subscription = described_class.new
    expect(subscription.calculate_cost(offers)).to eq 20
  end
end
