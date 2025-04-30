Sequel.migration do
  up do
    alter_table(:favorites) do
      drop_foreign_key [:user]
      add_foreign_key [:user], :users, on_delete: :cascade
    end
  end

  down do
    alter_table(:favorites) do
      drop_foreign_key [:user]
      add_foreign_key [:user], :users
    end
  end
end
