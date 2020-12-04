# == Schema Information
#
# Table name: rooms
#
#  id            :integer          not null, primary key
#  password      :integer
#  singers_count :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  admin_id      :integer
#
class Room < ApplicationRecord

  # Relates Room to its singers 
  has_many(:singers, { :class_name => "Singer", :foreign_key => "room_id", :dependent => :destroy })
  # Relates Room to its Admin_user
  belongs_to(:admin, { :required => false, :class_name => "User", :foreign_key => "admin_id" })
  
  # Relates Room to Songs:
  has_many(:songs, { :through => :next_songs, :source => :song })
  # Relates Room to Songs_queue:
  has_many(:next_songs, { :through => :singers, :source => :next_songs })
  # Relates Room to its Singer_users:
  has_many(:users, { :through => :singers, :source => :user })
  
  # Validations:
  validates(:admin_id, { :presence => true })

end
