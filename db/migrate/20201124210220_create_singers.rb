class CreateSingers < ActiveRecord::Migration[6.0]
  def change
    create_table :singers do |t|
      t.integer :room_id
      t.integer :user_id
      t.integer :next_songs_count

      t.timestamps
    end
  end
end
