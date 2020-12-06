Rails.application.routes.draw do

  # Home directs to rooms (except if user not signed in):
  get("/", { :controller => "rooms", :action => "index" })
  
  # ------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

  # Routes for the Room resource:

  # CREATE
  post("/insert_room", { :controller => "rooms", :action => "create" })
          
  # READ
  get("/rooms", { :controller => "rooms", :action => "index" })
  
  get("/rooms/:path_id", { :controller => "rooms", :action => "show" })
  
  # UPDATE
  
  post("/modify_room/:path_id", { :controller => "rooms", :action => "update" })
  
  # DELETE
  get("/delete_room/:path_id", { :controller => "rooms", :action => "destroy" })

  # JOIN
  post("/join_room", { :controller => "rooms", :action => "join" })

  # RE-JOIN
  post("/re_join_room", { :controller => "rooms", :action => "re_join" })

  # LEAVE
  get("/leave_room", { :controller => "rooms", :action => "leave" })

  #------------------------------

  # Routes for the Singer resource:

  # CREATE
  post("/insert_singer", { :controller => "singers", :action => "create" })
          
  # READ
  get("/singers", { :controller => "singers", :action => "index" })
  
  get("/singers/:path_id", { :controller => "singers", :action => "show" })
  
  # UPDATE
  
  post("/modify_singer/:path_id", { :controller => "singers", :action => "update" })
  
  # DELETE
  get("/delete_singer/:path_id", { :controller => "singers", :action => "destroy" })

  #------------------------------

  # Routes for the Songs queue resource:

  # CREATE
  post("/insert_songs_queue", { :controller => "songs_queues", :action => "create" })
          
  # READ
  get("/songs_queues", { :controller => "songs_queues", :action => "index" })
  
  get("/songs_queues/:path_id", { :controller => "songs_queues", :action => "show" })
  
  # UPDATE
  
  post("/modify_songs_queue/:path_id", { :controller => "songs_queues", :action => "update" })
  
  # DELETE
  get("/delete_songs_queue/:path_id", { :controller => "songs_queues", :action => "destroy" })

  #------------------------------

  # Routes for the Song resource:

  # CREATE
  post("/insert_song", { :controller => "songs", :action => "create" })
          
  # READ
  get("/songs", { :controller => "songs", :action => "index" })
  
  get("/songs/:path_id", { :controller => "songs", :action => "show" })
  
  # UPDATE
  
  post("/modify_song/:path_id", { :controller => "songs", :action => "update" })
  
  # DELETE
  get("/delete_song/:path_id", { :controller => "songs", :action => "destroy" })

  #------------------------------

end
