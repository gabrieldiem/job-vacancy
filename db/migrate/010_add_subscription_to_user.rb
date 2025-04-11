SUBSCRIPTION_TYPE_ON_DEMAND = 0
SUBSCRIPTION_TYPE_NON_PROFIT_ORGANIZATION = 1

Sequel.migration do
  up do
    add_column :users, :subscription_type, Integer, default: SUBSCRIPTION_TYPE_ON_DEMAND
  end

  down do
    drop_column :users, :subscription_type
  end
end
