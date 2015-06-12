class ParserController < ApplicationController
    require 'csv'
    
    def parse
        
        this_dir = File.dirname(__FILE__)
        file_path = File.join(this_dir, 'lib', 'parks.csv')
        
        # Ans by Tom De Leu 2012
        CSV.foreach(file_path, :headers => true) do |row|
            
            parkHasWashroom = false;
            if row[14] = 'Y'
                parkHasWashroom = true
            end
            
            latlng = row[7].split(',')
            
            Park.create!(:name => row[1], :lat =>  latlng[0].to_f, :lng => latlng[1].to_f, :hasWashroom => parkHasWashroom)
        end
    end
    
end
