Sequel.migration do
  up do
    add_column :job_offers, :experience_required, Integer
  end

  down do
    drop_column :job_offers, :experience_required
  end
end
