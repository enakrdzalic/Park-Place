class PagesController < ApplicationController
	
    
    @userId = 0;

	 def map
         @parks=Park.all
         parkIdHash = Hash.new
         userIdHash = Hash.new
         i = 0
         Favourite.all.each do |fav| 
         	parkIdHash[i] = fav.park_id
         	userIdHash[i] = fav.user_id
         	i = i + 1
         end
         @favParkIds = parkIdHash
         @favUserIds = userIdHash

     end

     def index
     end

     def getFavs
         userId = params[:userId].to_s
         user = User.find_by_uid(userId);
         #@favourites=user.getFavourites();
         

    end


end
