class RoomsController < ApplicationController
  
  # I want users to create or join a room before other actions
  skip_before_action(:force_singer_sign_in, { :only => [:index, :create, :join, :re_join] })
  
  def index
    matching_rooms = Room.all

    @list_of_rooms = matching_rooms.order({ :created_at => :desc })

    render({ :template => "rooms/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")
    matching_rooms = Room.where({ :id => the_id })
    @the_room = matching_rooms.at(0)

    @the_songs_queue = @the_room.next_songs

    # Determine if user has entered the page specifically to play a song next and, in that case, sets @autoplay to 1 and updates previous song to played
    the_next_song_id = params.fetch("query_song_id", nil)
    play_next_song = params.fetch("query_play_next", nil)
    if the_next_song_id != nil || play_next_song == "true"
      @autoplay = 1
      previous_song_id = session[:previous_song_id]
      if previous_song_id != nil
        previous_song = SongsQueue.where({ :id => previous_song_id.to_i }).first
        # Do I need to update all fields??
        previous_song.played = true
        if previous_song.valid?
          previous_song.save
        end
      end
    else
      @autoplay = 0
    end

    # Determine next song to appear in the youtube embedded frame
    if the_next_song_id == nil
      if @the_songs_queue.where({ :played => false }) != nil
        the_next_song = @the_songs_queue.where({ :played => false }).first
      else
        # Add notice saying there is no song left unplayed in songs queue
      end
    else
      if @the_songs_queue.where({ :id => the_next_song_id.to_i }) != nil
        the_next_song = @the_songs_queue.where({ :id => the_next_song_id.to_i }).first
      else
        # Add notice saying "failed to find song in songs queue"
      end
    end

    # Uses extract_video_id from this gem: https://github.com/datwright/youtube_addy
    @youtube_video_id = the_next_song.song.url.extract_video_id
    session[:previous_song_id] = the_next_song.id

    render({ :template => "rooms/show.html.erb" })
  end

  def create
    the_room = Room.new
    the_room.admin_id = @current_user.id
    the_room.singers_count = 0
    the_room.password = 1000 + rand(9000)

    if the_room.valid?
      the_room.save
      
      # Should I create this in the singers_controller?
      the_singer = Singer.new
      the_singer.room_id = the_room.id
      the_singer.user_id = @current_user.id
      the_singer.next_songs_count = 0
      the_singer.save
      session[:singer_id] = the_singer.id

      redirect_to("/rooms/" + the_room.id.to_s , { :notice => "Room created successfully." })
    else
      redirect_to("/rooms", { :notice => "Room failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_room = Room.where({ :id => the_id }).at(0)

    the_room.admin_id = params.fetch("query_admin_id")
    the_room.singers_count = params.fetch("query_singers_count")

    if the_room.valid?
      the_room.save
      redirect_to("/rooms/#{the_room.id}", { :notice => "Room updated successfully."} )
    else
      redirect_to("/rooms/#{the_room.id}", { :alert => "Room failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_room = Room.where({ :id => the_id }).at(0)

    the_room.destroy

    redirect_to("/rooms", { :notice => "Room deleted successfully."} )
  end

  def join
    the_room_id = params.fetch("query_room_id")
    the_room_password = params.fetch("query_room_password_id").to_i
    the_room = Room.where({ :id => the_room_id }).at(0)
    
    if the_room != nil
      if Singer.where({ :room_id => the_room.id , :user_id => @current_user.id }).at(0) != nil
        # Allow singer to re-join room s/he left (possibly do this through the re-join button?)
        session[:singer_id] = Singer.where({ :room_id => the_room.id , :user_id => @current_user.id }).at(0).id
        redirect_to("/rooms/#{the_room.id}", { :notice => "Re-joined room successfully." })
      elsif the_room.password == the_room_password
        # Should I create this in the singers_controller?
        the_singer = Singer.new
        the_singer.room_id = the_room.id
        the_singer.user_id = @current_user.id
        the_singer.next_songs_count = 0
        the_singer.save
        session[:singer_id] = the_singer.id
        redirect_to("/rooms/" + the_room.id.to_s, { :notice => "Joined room successfully." })
      else
        redirect_to("/rooms", { :alert => "Incorrect room password." })
      end
    else
      redirect_to("/rooms", { :alert => "Room #{the_room_id} does not exist." })
    end

  end

  def re_join
    the_room_id = params.fetch("query_room_id")
    the_room = Room.where({ :id => the_room_id }).at(0)
    
    if the_room != nil
      if Singer.where({ :room_id => the_room.id , :user_id => @current_user.id }).at(0) != nil
        session[:singer_id] = Singer.where({ :room_id => the_room.id , :user_id => @current_user.id }).at(0).id
        redirect_to("/rooms/#{the_room.id}", { :notice => "Re-joined room successfully." })
      else
        redirect_to("/rooms", { :alert => "You are still not a singer in room #{the_room.id}." })
      end
    else
      redirect_to("/rooms", { :alert => "Room #{the_room_id} does not exist." })
    end

  end

  def leave
    session[:singer_id] = nil
    session[:previous_song_id] = nil
    redirect_to("/rooms", { :notice => "You left your room successfully." })
  end

end
