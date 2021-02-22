ROM::SQL.migration do
  change do
    create_table :clients_episodes_liked do
      primary_key :id
      foreign_key :client_id, :clients
      foreign_key :episode_id, :episodes
    end
  end
end
