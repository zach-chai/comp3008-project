class User < ActiveRecord::Base
  has_many :registered_courses
  has_many :courses, through: :registered_courses

  def gpa
    sum = 0
    finished_courses = registered_courses.where.not(grade: nil)
    finished_courses.map(&:grade).each { |grade| sum += grade}
    sum / finished_courses.length
  end

  def credits
    registered_courses.where.not(grade: nil).count / 2
  end
end
