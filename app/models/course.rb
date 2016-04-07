class Course < ActiveRecord::Base
  belongs_to :professor
  belongs_to :faculty
  has_many :registered_courses
  has_many :users, through: :registered_courses
end
