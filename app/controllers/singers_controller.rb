class SingersController < ApplicationController
  # def index
  #   matching_singers = Singer.all

  #   @list_of_singers = matching_singers.order({ :created_at => :desc })

  #   render({ :template => "singers/index.html.erb" })
  # end

  # def show
  #   the_id = params.fetch("path_id")

  #   matching_singers = Singer.where({ :id => the_id })

  #   @the_singer = matching_singers.at(0)

  #   render({ :template => "singers/show.html.erb" })
  # end

  # def create
  #   the_singer = Singer.new
  #   the_singer.room_id = params.fetch("query_room_id")
  #   the_singer.user_id = params.fetch("query_user_id")
  #   the_singer.next_songs_count = params.fetch("query_next_songs_count")

  #   if the_singer.valid?
  #     the_singer.save
  #     redirect_to("/singers", { :notice => "Singer created successfully." })
  #   else
  #     redirect_to("/singers", { :notice => "Singer failed to create successfully." })
  #   end
  # end

  # def update
  #   the_id = params.fetch("path_id")
  #   the_singer = Singer.where({ :id => the_id }).at(0)

  #   the_singer.room_id = params.fetch("query_room_id")
  #   the_singer.user_id = params.fetch("query_user_id")
  #   the_singer.next_songs_count = params.fetch("query_next_songs_count")

  #   if the_singer.valid?
  #     the_singer.save
  #     redirect_to("/singers/#{the_singer.id}", { :notice => "Singer updated successfully."} )
  #   else
  #     redirect_to("/singers/#{the_singer.id}", { :alert => "Singer failed to update successfully." })
  #   end
  # end

  # def destroy
  #   the_id = params.fetch("path_id")
  #   the_singer = Singer.where({ :id => the_id }).at(0)

  #   the_singer.destroy

  #   redirect_to("/singers", { :notice => "Singer deleted successfully."} )
  # end
end
