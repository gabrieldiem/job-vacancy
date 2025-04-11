class SubscriptionFactory
  SUBSCRIPTION_TYPE_ON_DEMAND = 0

  def create_subscription(subscription_type, email)
    case subscription_type
    when SUBSCRIPTION_TYPE_ON_DEMAND
      OnDemandSubscription.new
    when nil
      OnDemandSubscription.new
    else
      NonProfitOrganizationSubscription.new email
    end
  end
end
