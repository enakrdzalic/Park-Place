json.array!(@marker_managers) do |marker_manager|
  json.extract! marker_manager, :id
  json.url marker_manager_url(marker_manager, format: :json)
end
