ROM::SQL.migration do
  change do
    alter_table(:seasons) do
      add_column :release_date, String, null: false, default: '2021-01-01'
    end
  end
end
