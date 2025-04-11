class OnDemandSubscription
  COST_PER_OFFER = 10

  def initialize
    @cost_per_offer = COST_PER_OFFER
  end

  def calculate_cost(offers)
    offers.size * @cost_per_offer
  end
end
