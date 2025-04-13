class InvalidEmailForNonProfitOrganizationSubscriptionException < StandardError
  def initialize(msg = 'Email should be from a .org domain')
    super
  end
end
