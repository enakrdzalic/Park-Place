class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    
    
    helper_method :updateData
    
    #File location :  ftp://webftp.vancouver.ca/opendata/csv/csv_parks_facilities.zip
    
    def getParksCSV
        require 'net/ftp'
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
        require 'zip'
        
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
    
    def updateData
        
        canUpdate = params[:canUpdate]
        if canUpdate
            Park.delete_all
            getParksCSV
            unzipThis
            parse
            render :nothing => true
        end
    end
end

