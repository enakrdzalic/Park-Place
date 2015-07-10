class User < ActiveRecord::Base
    has_many :favourites
    has_many :parks, through:  :favourites
    
    
    def addFavourite(p)

        if (has5Favourites == false)
            Favourite.create(:user_id => self.id, :park_id => p.parkID)
            return true
        end
        
        return false
    end
    
    
    
    def removeFavourite(p)
        Favourite.where(["user_id = ? and park_id = ?", self.id, p.parkID]).first.delete
    end
    
    
    
    def has5Favourites
        numFavs = Favourite.where("user_id = #{userID}").length
        if numFavs >= 5
            return true
        end
        
        return false
    end
    
    
    
    def getFavourites
        userID = self.id
        return Favourite.where("user_id = #{userID}").all
    end
    
end
