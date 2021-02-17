ROM::SQL.migration do
  change do
    create_table :clients_contents_liked do
      primary_key :id
      foreign_key :client_id, :clients
      foreign_key :content_id, :contents
    end
  end
end
