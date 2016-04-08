
$(document).on 'ready page:load', ->
  populateFacultyList = ->
    $("#faculty-list button").remove()
    $.get "/faculties.json"
    .done (data) ->
      for faculty in data
        $("#faculty-list").append "<button type=\"button\" class=\"list-group-item\" data-faculty=\"#{faculty.code}\">#{faculty.name}</button>"

  populateCourseList = (faculty) ->
    $("#course-list button").remove()
    param = ""
    if faculty
      param = "?faculty=#{faculty}"
    $.get "/courses.json#{param}"
    .done (data) ->
      for course in data
        $("#course-list").append "<button type=\"button\" class=\"list-group-item\" data-id=\"#{course.id}\" data-code=\"#{course.code}\">#{course.name}</button>"

  populateCourseInfo = (course) ->
    $("#course-info p").remove()
    $.get "/courses/#{course}.json"
    .done (data) ->
      $("#course-info").append "
      <p>#{data.name}</p>
      <p>#{data.code}</p>
      <p>#{data.professor.name}</p>
      <p>#{data.day}</p>
      <p>#{data.pretty_start_time} #{data.pretty_end_time}</p>
      <p>#{data.prerequisites}</p>
      "

  $("#faculty-list").on "click", "button", ->
    faculty = $(this).data 'faculty'
    populateCourseList faculty

  $("#course-list").on "click", "button", ->
    course = $(this).data 'id'
    populateCourseInfo course

  populateFacultyList()
  populateCourseList()
