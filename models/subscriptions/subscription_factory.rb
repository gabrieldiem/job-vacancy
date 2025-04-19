require_relative './subscription_types_consts'
require_relative './on_demand_subscription'
require_relative './non_profit_organization_subscription'

class SubscriptionFactory
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
