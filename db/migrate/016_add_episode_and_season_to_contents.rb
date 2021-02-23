ROM::SQL.migration do
  change do
    alter_table(:contents) do
      add_column :episode_number, :integer, null: true
      add_column :season, :integer, null: true
    end
  end
end
