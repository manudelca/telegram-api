ROM::SQL.migration do
  change do
    alter_table(:contents) do
      set_column_allow_null :name
      set_column_allow_null :audience
      set_column_allow_null :duration_minutes
      set_column_allow_null :genre_id
      set_column_allow_null :country
      set_column_allow_null :director
      set_column_allow_null :first_actor
      set_column_allow_null :second_actor
      set_column_allow_null :release_date
    end
  end
end
