require_relative './invalid_email_exception'
class NonProfitOrganizationSubscription
  FREE_COST = 0.0

  def initialize(email)
    raise InvalidEmailForNonProfitOrganizationSubscriptionException unless email.end_with?('.org')
  end

  def calculate_cost(_offers)
    FREE_COST
  end
end
