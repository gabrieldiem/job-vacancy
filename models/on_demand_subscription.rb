class OnDemandSubscription
  COST_PER_OFFER = 10
  DECIMALS = 1

  def initialize
    @cost_per_offer = COST_PER_OFFER
  end

  def calculate_cost(offers)
    total = 0
    offers.each do |offer|
      total += @cost_per_offer if offer.is_active?
    end
    total.round(DECIMALS)
  end
end
