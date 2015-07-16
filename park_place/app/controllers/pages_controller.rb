class PagesController < ApplicationController
	 def map
         @parks=Park.all
         @favourites=Favourite.all
     end

     def index
     end
end
