class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.text :cast
      t.string :director
      t.date :release
      t.integer :duration
      t.string :genre
      t.integer :rate

      t.timestamps
    end
  end
end
