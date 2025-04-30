Sequel.migration do
  up do
    drop_column :favorites, :job_offer
    drop_column :favorites, :user

    add_column :favorites, :job_offer_id, Integer
    add_column :favorites, :user_id, Integer

    alter_table(:favorites) do
      add_foreign_key [:job_offer_id], :job_offers, on_delete: :cascade
      add_foreign_key [:user_id], :users, on_delete: :cascade
    end
  end

  down do
    drop_column :favorites, :job_offer_id
    drop_column :favorites, :user_id

    add_column :favorites, :job_offer, Integer
    add_column :favorites, :user, Integer

    alter_table(:favorites) do
      add_foreign_key [:job_offer], :job_offers, on_delete: :cascade
      add_foreign_key [:user], :users, on_delete: :cascade
    end
  end
end
