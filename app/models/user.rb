class User < ActiveRecord::Base
  has_many :registered_courses
  has_many :courses, through: :registered_courses
end
