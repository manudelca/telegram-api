ROM::SQL.migration do
  change do
    create_table :seasons do
      primary_key :id
      column :number, Integer, null: false
    end
  end
end
