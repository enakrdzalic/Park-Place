require 'test_helper'

class ParserControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
end


def test_import_csv
  csv_rows = <<-eos
Name1,name1@example.com
Name2,name2@example.com
Name3,name3@example.com
  eos

  file = Tempfile.new('parks.csv')
  file.write(csv_rows)
  file.rewind

  assert_difference "User.count", 3 do
    post :csv_import, :file => Rack::Test::UploadedFile.new(file, 'text/csv')
  end

  assert_redirected_to your_path
  assert_equal "Successfully imported the CSV file.", flash[:notice]
end