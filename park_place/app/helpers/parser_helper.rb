module ParserHelper
    
    def parse
        require 'csv'
        this_dir = File.dirname(__FILE__)
        file_path = File.join(this_dir, 'lib', 'parks.csv')
        
        temp_index = 0
        
        # Solution by Tom De Leu 2012
        CSV.foreach(file_path, :headers => true) do |row|
            
            parkHasWashroom = nil;
            if row[14] == "Y"
                parkHasWashroom = "Washroom"
            end
            
            parkIsLarge = "Small";
            if row[8].to_f >= 1.0
                parkIsLarge = "Large";
            end
            
            latlng = row[7].split(',')
            
            Park.create!(:name => row[1], :lat =>  latlng[0].to_f,
                         :lng => latlng[1].to_f, :hasWashroom => parkHasWashroom,
                         :index => temp_index, :isLarge => parkIsLarge, :neighbourhood => row[9])
                         
                         temp_index+=1
        end
        
    end
    
end
