class SongsQueuesController < ApplicationController
  def index
    matching_songs_queues = SongsQueue.all

    @list_of_songs_queues = matching_songs_queues.order({ :created_at => :desc })

    render({ :template => "songs_queues/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_songs_queues = SongsQueue.where({ :id => the_id })

    @the_songs_queue = matching_songs_queues.at(0)

    render({ :template => "songs_queues/show.html.erb" })
  end

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

  def update
    the_id = params.fetch("path_id")
    the_songs_queue = SongsQueue.where({ :id => the_id }).at(0)

    the_songs_queue.song_id = params.fetch("query_song_id")
    the_songs_queue.singer_id = params.fetch("query_singer_id")
    the_songs_queue.played = params.fetch("query_played", false)

    if the_songs_queue.valid?
      the_songs_queue.save
      redirect_to("/songs_queues/#{the_songs_queue.id}", { :notice => "Songs queue updated successfully."} )
    else
      redirect_to("/songs_queues/#{the_songs_queue.id}", { :alert => "Songs queue failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_songs_queue = SongsQueue.where({ :id => the_id }).at(0)

    the_songs_queue.destroy

    redirect_to("/songs_queues", { :notice => "Songs queue deleted successfully."} )
  end
end
