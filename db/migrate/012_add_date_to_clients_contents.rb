ROM::SQL.migration do
  change do
    alter_table(:clients_contents) do
      add_column :date, String
    end
  end
end
