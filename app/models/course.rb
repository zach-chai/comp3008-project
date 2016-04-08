class Course < ActiveRecord::Base
  belongs_to :professor
  belongs_to :faculty
  has_many :registered_courses
  has_many :users, through: :registered_courses

  def pretty_time(time)
    time.strftime "%l:%M"
  rescue
    nil
  end

  def pretty_start_time
    pretty_time start_time
  end

  def pretty_end_time
    pretty_time end_time
  end

  def self.on_day(day)
    where 'day like (?)', "%#{day}%"
  end
end
