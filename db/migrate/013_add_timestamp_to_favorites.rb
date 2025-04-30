Sequel.migration do
  up do
    add_column :favorites, :created_on, Date
    add_column :favorites, :updated_on, Date
  end

  down do
    drop_column :favorites, :created_on
    drop_column :favorites, :updated_on
  end
end
