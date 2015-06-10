json.array!(@parks) do |park|
  json.extract! park, :id, :name, :lat, :lon, :hasWashroom
  json.url park_url(park, format: :json)
end
