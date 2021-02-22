ROM::SQL.migration do
  change do
    alter_table(:clients_episodes) do
      add_column :date, String, null: false, default: '2021-01-01'
    end
  end
end
