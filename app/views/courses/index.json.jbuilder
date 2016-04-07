json.array!(@courses) do |course|
  json.extract! course, :id, :name, :code, :term, :year, :prerequisites, :professor_id, :faculty_id
  json.url course_url(course, format: :json)
end
