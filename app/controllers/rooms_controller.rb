class RoomsController < ApplicationController
  def index
    matching_rooms = Room.all

    @list_of_rooms = matching_rooms.order({ :created_at => :desc })

    render({ :template => "rooms/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_rooms = Room.where({ :id => the_id })

    @the_room = matching_rooms.at(0)

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
      # Does this work? Or once I save it, I lose the_singer?
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
        # Does this work? Or once I save it, I lose the_singer?
        session[:singer_id] = the_singer.id
        redirect_to("/rooms/" + the_room.id.to_s, { :notice => "Joined room successfully." })
      else
        redirect_to("/rooms", { :alert => "Incorrect room password." })
      end
    else
      redirect_to("/rooms", { :alert => "Room #{the_room_id} does not exist" })
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
        redirect_to("/rooms", { :alert => "You are still not a singer in room #{the_room.id}" })
      end
    else
      redirect_to("/rooms", { :alert => "Room #{the_room_id} does not exist" })
    end

  end

end
