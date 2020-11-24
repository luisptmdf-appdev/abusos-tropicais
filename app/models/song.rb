# == Schema Information
#
# Table name: songs
#
#  id         :integer          not null, primary key
#  artist     :string
#  name       :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class Song < ApplicationRecord
  
  # Relates songs to rooms:
  has_many(:next_songs, { :through => :next_songs, :source => :singer })
  # Less important:
  belongs_to(:user, { :required => false, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })
  # Possibly unnecessary:
  has_many(:next_songs, { :class_name => "SongsQueue", :foreign_key => "song_id", :dependent => :destroy })

  # Validations:
  validates(:user_id, { :presence => true })
  validates(:url, { :presence => true })
  validates(:url, { :uniqueness => true })
  validates(:name, { :presence => true })
  
end
