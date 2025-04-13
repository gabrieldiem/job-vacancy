require_relative './invalid_email_exception'
class NonProfitOrganizationSubscription
  FREE_COST = 0.0
  SUBSCRIPTION_TYPE_NON_PROFIT_ORGANIZATION = 1
  ORG_TLD = '.org'.freeze

  attr_reader :id

  def initialize(email)
    raise InvalidEmailForNonProfitOrganizationSubscriptionException unless email.end_with?(ORG_TLD)

    @id = SUBSCRIPTION_TYPE_NON_PROFIT_ORGANIZATION
  end

  def calculate_cost(_offers)
    FREE_COST
  end
end
