class NonProfitOrganizationSubscription
  FREE_COST = 0.0

  def initialize(email); end

  def calculate_cost(_offers)
    FREE_COST
  end
end
