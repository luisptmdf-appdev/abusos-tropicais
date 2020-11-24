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
    the_room.admin_id = params.fetch("query_admin_id")
    the_room.singers_count = params.fetch("query_singers_count")

    if the_room.valid?
      the_room.save
      redirect_to("/rooms", { :notice => "Room created successfully." })
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
end
