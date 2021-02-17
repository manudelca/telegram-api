ROM::SQL.migration do
  change do
    alter_table(:clients) do
      drop_column :username
      add_column :telegram_user_id, :integer
    end
  end
end
