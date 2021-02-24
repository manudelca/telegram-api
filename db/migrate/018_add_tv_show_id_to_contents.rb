ROM::SQL.migration do
  change do
    alter_table(:contents) do
      add_column :tv_show_id, :integer, null: true
      rename_column :season, :season_number
    end
  end
end
