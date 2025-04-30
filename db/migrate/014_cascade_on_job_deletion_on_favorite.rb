Sequel.migration do
  up do
    alter_table(:favorites) do
      drop_foreign_key [:job_offer]
      add_foreign_key [:job_offer], :job_offers, on_delete: :cascade
    end
  end

  down do
    alter_table(:favorites) do
      drop_foreign_key [:job_offer]
      add_foreign_key [:job_offer], :job_offers
    end
  end
end
