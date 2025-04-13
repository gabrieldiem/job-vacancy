require 'spec_helper'

describe OnDemandSubscription do
  let(:subscription_type_on_demand) { 0 }

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

  it 'OnDemandSubscription should have ID = subscription_type_on_demand' do
    subscription = described_class.new
    expect(subscription.id).to eq subscription_type_on_demand
  end

  it 'OnDemandSubscription does have allowance if user has 100 active offers' do
    subscription = described_class.new
    active_offers = 100
    expect(subscription.has_allowance?(active_offers)).to be true
  end
end
