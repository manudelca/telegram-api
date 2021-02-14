ROM::SQL.migration do
  change do
    alter_table(:seasons) do
      add_foreign_key :tv_show_id, :contents
    end
  end
end
