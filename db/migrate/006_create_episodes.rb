ROM::SQL.migration do
  change do
    create_table :episodes do
      primary_key :id
      column :number, Integer, null: false
    end
  end
end
