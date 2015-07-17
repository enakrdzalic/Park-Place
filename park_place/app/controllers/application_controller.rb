require 'csv'
require 'zip'
require 'net/ftp'

class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :updateData

    ParkSizeBorder = 1.0
    
    def updateData
        canUpdate = params[:canUpdate]
        if canUpdate
            Park.delete_all
            getParksCSV
            unzipThis
            parse('parks.csv', 'lib')
            render :nothing => true
        end
    end

    def changeFavourite
        parkID = params[:parkID]
        userID = params[:userID]
        if (isNotFavourite(userID, parkID))
            Favourite.create(:uid => userID.to_s, :park_id => parkID.to_i)
         else 
            Favourite.where(["uid = ? and park_id = ?", userID, parkID]).first.delete
        end
    end

private

    def getParksCSV
        ftp = Net::FTP.new
        ftp.connect("webftp.vancouver.ca",21)
        ftp.login()
        ftp.chdir("/opendata/")
        ftp.chdir("csv")
        ftp.passive = true
        
        this_dir = File.dirname(__FILE__)
        file_path = File.join(this_dir, 'lib','parks_csv.zip')
        ftp.getbinaryfile("csv_parks_facilities.zip", file_path)
    end
    
    def unzipThis
        this_dir = File.dirname(__FILE__)
        file_path = File.join(this_dir, 'lib','parks_csv.zip')
        dest_path = File.join(this_dir, 'lib')
        
        Zip::File.open(file_path) do |zipfile|
            zipfile.each do |file|
                f_path=File.join(dest_path, file.name)
                FileUtils.mkdir_p(File.dirname(f_path))
                zipfile.extract(file, f_path){true}
                
            end
        end
    end

    def hasWashroom(park_washroom)
        return (park_washroom == "Y")
    end
    
    def isLargePark(size)
        return (size.to_f >= ParkSizeBorder)
    end

    def parse(park_file_name,lib_name)
        this_dir = File.dirname(__FILE__)
        file_path = File.join(this_dir, lib_name, park_file_name)
        
        temp_index = 0
        CSV.foreach(file_path, :headers => true) do |row|
            
            parkHasWashroom = nil;
            if (hasWashroom(row[14]))
                parkHasWashroom = "Washroom"
            end
            
            parkIsLarge = "Small";
            if (isLargePark(row[8]))
                parkIsLarge = "Large";
            end
            
            latlng = row[7].split(',')
            
            Park.create!(:name => row[1], :lat =>  latlng[0].to_f,
                         :lng => latlng[1].to_f, :hasWashroom => parkHasWashroom,
                         :index => temp_index, :isLarge => parkIsLarge, :neighbourhood => row[9],
                         :parkID => row[0])
                         
            temp_index+=1
        end
    end

    def isNotFavourite(user_id, park_id)
        return (Favourite.where(["uid = ? and park_id = ?", user_id, park_id]).first == nil)
    end

end

