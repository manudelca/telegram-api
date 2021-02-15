ROM::SQL.migration do
  change do
    alter_table(:contents) do
      add_column :audience, String, null: false, default: 'ATP'
      add_column :duration_minutes, Integer, null: false, default: 190
      add_foreign_key :genre_id, :genres
      add_column :country, String, null: false, default: 'USA'
      add_column :director, String, null: false, default: 'James Cameron'
      add_column :release_date, String, null: false, default: '2021-01-01'
      add_column :first_actor, String, null: false, default: 'Leonardo Dicaprio'
      add_column :second_actor, String
    end
  end
end
