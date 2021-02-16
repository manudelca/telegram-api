ROM::SQL.migration do
  change do
    alter_table(:episodes) do
      add_foreign_key :season_id, :seasons
    end
  end
end
