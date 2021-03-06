class ApplicationController < ActionController::Base
  
  before_action(:load_current_user)
  # Uncomment this if you want to force users to sign in before any other actions
  before_action(:force_user_sign_in)
  
  # Creating a variable called @current_singer, to be used throughout the application
  before_action(:load_current_singer)
  # I want user to become a singer (i.e. create or join a room) before continuing
  before_action(:force_singer_sign_in)
  
  def load_current_user
    the_id = session[:user_id]
    @current_user = User.where({ :id => the_id }).first
  end
  
  def force_user_sign_in
    if @current_user == nil
      redirect_to("/user_sign_in", { :notice => "You have to sign in first." })
    end
  end

  def load_current_singer
    the_id = session[:singer_id]
    @current_singer = Singer.where({ :id => the_id }).first
  end

  def force_singer_sign_in
    if @current_user != nil && @current_singer == nil
      redirect_to("/rooms", { :notice => "You have to create or join a room first." })
    end
  end

end
