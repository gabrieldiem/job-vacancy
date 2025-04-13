class OnDemandSubscription
  COST_PER_OFFER = 10
  DECIMALS = 1
  SUBSCRIPTION_TYPE_ON_DEMAND = 0
  LIMIT_ALWAYS_AVAILABLE = true

  attr_reader :id

  def initialize
    @cost_per_offer = COST_PER_OFFER
    @id = SUBSCRIPTION_TYPE_ON_DEMAND
  end

  def calculate_cost(offers)
    total = 0
    offers.each do |offer|
      total += @cost_per_offer if offer.is_active?
    end
    total.round(DECIMALS)
  end

  def has_allowance?(_active_offers)
    LIMIT_ALWAYS_AVAILABLE
  end
end
