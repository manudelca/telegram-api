ROM::SQL.migration do
  change do
    alter_table(:contents) do
      add_column :type, String, null: false, default: 'movie'
    end
  end
end
