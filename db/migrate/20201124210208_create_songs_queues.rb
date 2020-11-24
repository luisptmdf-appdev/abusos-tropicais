class CreateSongsQueues < ActiveRecord::Migration[6.0]
  def change
    create_table :songs_queues do |t|
      t.integer :song_id
      t.integer :singer_id
      t.boolean :played

      t.timestamps
    end
  end
end
