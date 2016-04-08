json.extract! @course, :id, :name, :code, :term, :year, :day, :start_time, :end_time, :prerequisites, :professor_id, :faculty_id, :created_at, :updated_at

json.professor do
  json.extract! @course.professor, :id, :name
end

json.pretty_start_time @course.pretty_start_time
json.pretty_end_time @course.pretty_end_time

json.audit do
  json.in_progress @course.registered_courses.first.present?
  if @course.registered_courses.first.present?
    json.completed @course.registered_courses.first.grade.present?
  end
end
