class SongsQueuesController < ApplicationController
  
  def create
    the_songs_queue = SongsQueue.new
    the_songs_queue.song_id = params.fetch("query_song_id")
    the_songs_queue.singer_id = @current_singer.id
    the_songs_queue.played = false

    if the_songs_queue.valid?
      the_songs_queue.save
      redirect_to("/rooms/#{@current_singer.room.id}", { :notice => "Song " + the_songs_queue.song.name.to_s + " added successfully." })
    else
      redirect_to("/songs", { :notice => "Failed to add song successfully." })
    end
  end

end
