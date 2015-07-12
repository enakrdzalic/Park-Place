class User < ActiveRecord::Base
    has_many :favourites
    has_many :parks, through:  :favourites
    
    
    def addFavourite(p)

        if (has5Favourites == false)
            Favourite.create(:user_id => self.uid, :park_id => p.parkID)
            return true
        end
        
        return false
    end
    
    
    
    def removeFavourite(p)
        Favourite.where(["user_id = ? and park_id = ?", self.uid.to_i, p.parkID.to_i]).first.delete
    end
    
    
    
    def has5Favourites
        userID = self.uid.to_i
        numFavs = Favourite.where("user_id = #{userID}").length
        if numFavs >= 5
            return true
        end
        
        return false
    end
    
    
    
    def getFavourites
        userID = self.uid.to_i
        return Favourite.where("user_id = #{userID}").all
    end
    
    def loginUser(userID, userName)
        
        if(User.find_by_uid(userID) == nil)
            User.create(:name => userName.to_s, :uid => userID.to_s)
        end
        
    end
end