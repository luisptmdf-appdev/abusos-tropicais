# == Schema Information
#
# Table name: singers
#
#  id               :integer          not null, primary key
#  next_songs_count :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  room_id          :integer
#  user_id          :integer
#
class Singer < ApplicationRecord

  # Relates Singer to her Next_songs (Songs_queue)
  has_many(:next_songs, { :class_name => "SongsQueue", :foreign_key => "singer_id", :dependent => :destroy })
  # Relates Singer to her Room
  belongs_to(:room, { :required => false, :class_name => "Room", :foreign_key => "room_id", :counter_cache => true })
  # Relates Singer to a User
  belongs_to(:user, { :required => false, :class_name => "User", :foreign_key => "user_id" })

  # Validations:
  validates(:user_id, { :presence => true })
  validates(:user_id, { :uniqueness => { :scope => ["room_id"] } })
  validates(:room_id, { :presence => true })

end
