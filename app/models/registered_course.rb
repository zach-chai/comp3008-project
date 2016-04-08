class RegisteredCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  # validates_uniqueness_of :user_id, :scope => [:course_id]
  validate :unique

  def unique
    if !RegisteredCourse.where(user_id: user_id, course_id: course_id, grade: nil).where.not(id: id).empty?
      errors.add(base: 'not unique')
    end
  end
end
