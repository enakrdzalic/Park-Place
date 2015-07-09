class User < ActiveRecord::Base
    has_many :favourites
    has_many :parks, through:  :favourites
end
