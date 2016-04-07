json.array!(@registered_courses) do |registered_course|
  json.extract! registered_course, :id, :user_id, :course_id, :grade
  json.url registered_course_url(registered_course, format: :json)
end
