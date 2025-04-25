# Helper methods defined here can be accessed in any controller or view in the application

JobVacancy::App.helpers do
  def get_subscription_name(subscription_type)
    types =
      { SUBSCRIPTION_TYPE_ON_DEMAND => 'On demand',
        SUBSCRIPTION_TYPE_NON_PROFIT_ORGANIZATION => 'Non-commercial organization' }
    types[subscription_type]
  end
end
