class PagesController < ApplicationController
	 def map
         @parks=Park.all
     end

     def index
     end
end
