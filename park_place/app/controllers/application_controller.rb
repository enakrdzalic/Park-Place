class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  

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
    require 'zip/zip'
    
    this_dir = File.dirname(__FILE__)
    file_path = File.join(this_dir, 'lib','parks_csv.zip')
    
    Zip::ZipFile.open(file_path) do |zipfile|
        zipfile.each do |file|
            # do something with file
        end
    end

end


  def parse
      require 'csv'
      this_dir = File.dirname(__FILE__)
      file_path = File.join(this_dir, 'lib', 'parks.csv')


      # Solution by Tom De Leu 2012
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
