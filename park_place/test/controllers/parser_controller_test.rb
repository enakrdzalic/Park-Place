require File.expand_path("../../test_helper", __FILE__)

class ParserControllerTest < ActionController::TestCase

  # def test_park

  #   stan_park = Park.new :parkID => parks(:stanley).parkID,
		# 			     :index => parks(:stanley).index,
		# 			     :name => parks(:stanley).name,
		# 			     :lat => parks(:stanley).lat,
		# 			     :lng => parks(:stanley).lng,
		# 			     :neighbourhood => parks(:stanley).neighbourhood,
		# 			     :hasWashroom => parks(:stanley).hasWashroom,
		# 			     :isLarge => parks(:stanley).isLarge

  #   assert stan_park.save

  #   stan_park_copy = Park.find(stan_park.id)

  #   assert_equal stan_park.name, stan_park_copy.name

  #   stan_park.name = "This is a cool park!"

  #   assert stan_park.save
  #   assert stan_park.destroy
  # end

  def test_park

  	park = Park.create( parkID: 0,
						index: 0,
						name: "Stanley Park",
						lat: 49,
						lng: -125,
						neighbourhood: "Downtown",
						hasWashroom: "Washroom",
						isLarge: "Large")
  	assert park.valid?

  end
end