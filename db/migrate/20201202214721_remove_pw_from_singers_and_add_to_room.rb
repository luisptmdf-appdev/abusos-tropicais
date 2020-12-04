class RemovePwFromSingersAndAddToRoom < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :password, :integer
    remove_column :singers, :password
  end
end
