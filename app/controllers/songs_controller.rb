class SongsController < ApplicationController
  def index
    
    @q = Song.ransack(params[:q])
    @list_of_songs = @q.result
    
    render({ :template => "songs/index.html.erb" })
  end

  def create
    the_song = Song.new
    the_song.name = params.fetch("query_name")
    the_song.artist = params.fetch("query_artist")
    the_song.user_id = @current_user.id
    the_song_url = params.fetch("query_url")
    the_song.url = the_song_url
    the_song_url_validation = YouTubeAddy.extract_video_id(the_song_url).class

    if the_song.valid? && the_song_url_validation == String
      the_song.save
      redirect_to("/songs", { :notice => "Song created successfully." })
    else
      redirect_to("/songs", { :notice => "Song failed to create successfully." })
    end
  end

end
