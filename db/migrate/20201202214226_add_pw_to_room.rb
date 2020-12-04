class AddPwToRoom < ActiveRecord::Migration[6.0]
  def change
    add_column :singers, :password, :integer
  end
end
