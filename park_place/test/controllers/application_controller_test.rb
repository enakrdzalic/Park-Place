require 'test_helper'
require 'application_controller'

class ApplicationControllerTest < ActionController::TestCase

  first = nil
  middle = nil
  last = nil

  def parse(park_file_name,lib_name)
    require 'csv'
    this_dir = File.dirname(__FILE__)
    file_path = File.join(this_dir, lib_name, park_file_name)

    temp_index = 0
    flash[:notice] = "Post successfully created"

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
                   :index => temp_index, :isLarge => parkIsLarge, :neighbourhood => row[9],
                   :parkID => row[0])

      temp_index+=1
    end

  end

  test "Run Before" do
    Park.delete_all
    parse('parks_test.csv', 'lib_test')
    first = Park.first
    middle = Park.third
    last = Park.fifth
  end

  test "First Park Name" do
    assert Park.first.name == "Test Park 1"
  end

  test "Middle Park Name" do
    assert middle.name == "Test Park 3"
  end

  test "End Park Name" do
    assert last.name == "Test Park 5"
  end


  test "First Park LatLng" do
    assert first.lat == 49.249783
    assert first.lng == -123.155250
  end

  test "Middle Park LatLng" do
    assert middle.lat == 49.244397
    assert middle.lng == -123.156429
  end
  test "Last Park LatLng" do
    assert last.lat == 49.247623
    assert last.lng == -123.169948
  end

test "First Park Washroom" do
  assert first.hasWashroom == nil
end

  test "Middle Park Washroom" do
    assert middle.hasWashroom == "Washroom"
  end

  test "Last Park Washroom" do
    assert last.hasWashroom == nil
  end

  test "First Park Index" do
    assert Park.first.index == 0
  end

  test "Middle Park Index" do
    assert Park.third.index == 2
  end

  test "Last Park Index" do
    assert Park.fifth.index == 4
  end

  test "First Park Size" do
    assert Park.first.isLarge == "Large"
  end

  test "Middle Park Size" do
    assert Park.third.isLarge == "Large"
  end

  test "Last Park Size" do
    assert Park.fifth.isLarge == "Small"
  end

  test "First Park ID" do
    assert Park.first.parkID == 1
  end

  test "Middle Park ID" do
    assert Park.third.parkID == 3
  end

  test "Last Park ID" do
    assert Park.fifth.parkID == 5
  end



end








