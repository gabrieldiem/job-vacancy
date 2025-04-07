Sequel.migration do
  up do
    add_column :job_offers, :salary, Integer
  end

  down do
    drop_column :job_offers, :salary
  end
end
