class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.integer :admin_id
      t.integer :singers_count

      t.timestamps
    end
  end
end
