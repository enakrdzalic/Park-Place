class User < ActiveRecord::Base
    has_many :favourites
    has_many :parks, through:  :favourites
    
    
    def addFavourite(p)

            Favourite.create(:user_id => self.uid.to_i, :park_id => p.parkID.to_i)

    end
    
    
    
    def removeFavourite(p)
        Favourite.where(["user_id = ? and park_id = ?", self.uid.to_i,p.park_ID.to_i]).first.delete
    end
    
    
    
    def getFavourites
        userID = self.uid
        return Favourite.where("user_id = #{userID}").all
    end
    
end
