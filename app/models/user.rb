# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  name            :string
#  password_digest :string
#  songs_count     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  
  # Relates Admin_user to her Rooms:
  has_many(:admin_rooms, { :class_name => "Room", :foreign_key => "admin_id", :dependent => :destroy })
  # Relates User to Singers (a User in a Room)
  has_many(:singers, { :class_name => "Singer", :foreign_key => "user_id", :dependent => :destroy })
  # Relates User to the Songs she has added
  has_many(:songs, { :class_name => "Song", :foreign_key => "user_id", :dependent => :nullify })

  # Relates User to her Rooms (as a Singer, not only as an Admin)
  has_many(:user_rooms, { :through => :singers, :source => :room })

  # Validations:
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password
  validates(:name, { :presence => true })

end
