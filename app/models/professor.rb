class Professor < ActiveRecord::Base
  has_many :courses

  def link
    "http://www.ratemyprofessors.com/search.jsp?queryoption=HEADER&queryBy=teacherName&schoolName=Carleton+University&schoolID=1420&query=#{name.sub!(' ', '+')}"
  end
end
