Sequel.migration do
  up do
    create_table(:favorites) do
      primary_key :id
      foreign_key :user, :users
      foreign_key :job_offer, :job_offers
    end
  end

  down do
    drop_table(:favorites)
  end
end
