class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.string :name
      t.string :artist
      t.integer :user_id
      t.string :url

      t.timestamps
    end
  end
end
