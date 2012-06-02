class AddToSeeToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :to_see, :boolean
  end
end
