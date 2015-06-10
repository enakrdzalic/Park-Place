json.array!(@accesses) do |access|
  json.extract! access, :id
  json.url access_url(access, format: :json)
end
