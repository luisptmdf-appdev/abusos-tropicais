# == Schema Information
#
# Table name: songs_queues
#
#  id         :integer          not null, primary key
#  played     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  singer_id  :integer
#  song_id    :integer
#
class SongsQueue < ApplicationRecord
  
  # Relates Songs_queue to Room:
  has_one(:singer, { :through => :singer, :source => :room })
  # Relates Songs_queue to Song:
  belongs_to(:song, { :required => false, :class_name => "Song", :foreign_key => "song_id" })
  # Relates Songs_queue to Singer:
  belongs_to(:singer, { :required => false, :class_name => "Singer", :foreign_key => "singer_id", :counter_cache => :next_songs_count })
  
  # Validations:
  validates(:song_id, { :presence => true })
  validates(:singer_id, { :presence => true })
  
  ## Removed the following for issue with defining variable to false...
  # validates(:played, { :presence => true })

end
