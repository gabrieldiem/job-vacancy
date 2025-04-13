require_relative '../../models/subscriptions/subscription_types_consts'

Sequel.migration do
  up do
    add_column :users, :subscription_type, Integer, default: SUBSCRIPTION_TYPE_ON_DEMAND
  end

  down do
    drop_column :users, :subscription_type
  end
end
