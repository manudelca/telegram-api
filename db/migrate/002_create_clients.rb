ROM::SQL.migration do
  change do
    create_table :clients do
      primary_key :id
      column :email, String, null: false
    end
  end
end
