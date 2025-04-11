require 'spec_helper'

describe OnDemandSubscription do
  it 'Cost of 1 active offers is 10.0' do
    subscription = described_class.new
    expect(subscription.calculate_cost([JobOffer.new(title: 'a title', salary: 0, is_active: true)])).to eq 10.0
  end

  it 'Cost of 2 active offers is 20.0' do
    offers = []

    2.times do
      offers.push JobOffer.new(title: 'a title', salary: 0, is_active: true)
    end

    subscription = described_class.new
    expect(subscription.calculate_cost(offers)).to eq 20.0
  end

  it 'Cost of 3 inactive offers is 0.0' do
    offers = []

    2.times do
      offers.push JobOffer.new(title: 'a title', salary: 0, is_active: false)
    end

    subscription = described_class.new
    expect(subscription.calculate_cost(offers)).to eq 0.0
  end
end
