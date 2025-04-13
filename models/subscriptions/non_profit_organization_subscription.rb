require_relative '../exceptions/invalid_email_exception'
class NonProfitOrganizationSubscription
  FREE_COST = 0.0
  SUBSCRIPTION_TYPE_NON_PROFIT_ORGANIZATION = 1
  ORG_TLD = '.org'.freeze
  OFFERS_LIMIT = 7

  attr_reader :id

  def initialize(email)
    raise InvalidEmailForNonProfitOrganizationSubscriptionException unless email.end_with?(ORG_TLD)

    @id = SUBSCRIPTION_TYPE_NON_PROFIT_ORGANIZATION
  end

  def has_allowance?(active_offers)
    raise OffersLimitExceededException if active_offers >= OFFERS_LIMIT

    active_offers < OFFERS_LIMIT
  end

  def calculate_cost(_offers)
    FREE_COST
  end
end
