
$(document).on 'ready page:load', ->
  user = ->
    1

  term = ->
    "winter"

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
      $("#course-info-container").append "<div class=\"panel-footer\"><button type=\"button\" class=\"btn btn-default\" data-course-id=\"#{data.id}\">Add</button></div>"

  populateDay = (day) ->
    $.get "/courses.json?day=#{day}&user_id=#{user()}&term=#{term()}"
    .done (data) ->
      for course in data
        $("##{day}").append "<p class=\"course\" data-id=\"#{course.id}\">#{course.pretty_start_time} #{course.pretty_end_time} #{course.name}</p>"

  populateSchedule = ->
    populateDay "monday"
    populateDay "tuesday"
    populateDay "Wednesday"
    populateDay "thursday"
    populateDay "friday"

  $("#faculty-list").on "click", "button", ->
    faculty = $(this).data 'faculty'
    populateCourseList faculty

  $("#course-list").on "click", "button", ->
    course = $(this).data 'id'
    populateCourseInfo course

  $("#course-info-container").on "click", "button", ->
    course = $(this).data 'course-id'
    data = {
      registered_course: {
        course_id: course
      }
    }
    console.log data
    $.post '/registered_courses.json',
      data
    .done ->
      alert "success"

  $("#schedule").on "click", "p", ->
    course = $(this).data 'id'
    $.ajax
      url: '/deregister_course.json',
      type: 'DELETE',
      data:
        course_id: course
      success: ->
          alert "success"

  populateFacultyList()
  populateCourseList()
  populateSchedule()
