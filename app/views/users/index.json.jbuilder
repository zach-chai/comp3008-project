json.array!(@users) do |user|
  json.extract! user, :id, :name
  json.credits user.credits
  json.url user_url(user, format: :json)
end
