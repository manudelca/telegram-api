ROM::SQL.migration do
  change do
    add_column :clients, :username, String
  end
end
