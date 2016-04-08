
$(document).on 'ready page:load', ->
  user = ->
    1

  term = ->
    "winter"

  populateFacultyList = ->
    $.get "/faculties.json"
    .done (data) ->
      $("#faculty-list button").remove()
      for faculty in data
        $("#faculty-list").append "<button type=\"button\" class=\"list-group-item\" data-faculty=\"#{faculty.code}\">#{faculty.name} (#{faculty.code.toUpperCase()})</button>"

  populateCourseList = (faculty) ->
    param = ""
    if faculty
      param = "&faculty=#{faculty}"
    $.get "/courses.json?term=#{term()}#{param}"
    .done (data) ->
      $("#course-list button").remove()
      for course in data
        if course.audit.in_progress
          $("#course-list").append "<button type=\"button\" class=\"list-group-item list-group-item-warning\" data-id=\"#{course.id}\" data-code=\"#{course.code}\">#{course.name} (#{course.code.toUpperCase()})</button>"
        else
          $("#course-list").append "<button type=\"button\" class=\"list-group-item\" data-id=\"#{course.id}\" data-code=\"#{course.code}\">#{course.name} (#{course.code.toUpperCase()})</button>"

  populateCourseInfo = (course) ->
    $.get "/courses/#{course}.json"
    .done (data) ->
      $("#course-info p, #course-info-container .panel-footer").remove()
      $("#course-info").append "
        <p>#{data.name}</p>
        <p>#{data.code.toUpperCase()}</p>
        <p>#{data.professor.name}</p>
        <p>#{data.day}</p>
        <p>#{data.pretty_start_time} #{data.pretty_end_time}</p>
        <p>#{data.prerequisites}</p>
        <p>Credits 0.5</p>
      "
      $("#course-info-container").append "<div class=\"panel-footer\"><button type=\"button\" class=\"btn btn-default\" data-course-id=\"#{data.id}\">Add to Schedule</button></div>"

  populateDay = (day) ->
    $.get "/courses.json?day=#{day}&user_id=#{user()}&term=#{term()}"
    .done (data) ->
      for course in data
        if course.conflict
          $("##{day}").append "<p class=\"course text-danger\" data-id=\"#{course.id}\">#{course.pretty_start_time} #{course.pretty_end_time} #{course.name}</p>"
        else
          $("##{day}").append "<p class=\"course\" data-id=\"#{course.id}\">#{course.pretty_start_time} #{course.pretty_end_time} #{course.name}</p>"

  populateSchedule = ->
    $("#schedule p").remove()
    populateDay "monday"
    populateDay "tuesday"
    populateDay "wednesday"
    populateDay "thursday"
    populateDay "friday"

  populateAuditList = ->
    $.get "/courses.json?audit=true"
    .done (data) ->
      $("#audit-list li").remove()
      for course in data
        if course.audit.completed
          $("#audit-list").append "<li class=\"list-group-item list-group-item-success\">#{course.name} (#{course.code.toUpperCase()})</li>"
        else if course.audit.in_progress
          $("#audit-list").append "<li class=\"list-group-item list-group-item-warning\">#{course.name} (#{course.code.toUpperCase()})</li>"
        else
          $("#audit-list").append "<li class=\"list-group-item\">#{course.name} (#{course.code.toUpperCase()})</li>"
    $.get "/users.json"
    .done (data) ->
      $("#audit .panel-heading").html "<span>Audit</span> <span style=\"float:right;\" class=\"badge\">Credits #{data[0].credits}</span>"

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
    $.post '/registered_courses.json',
      data
    .done ->
      populateSchedule()
      populateAuditList()

  $("#schedule").on "click", "p", ->
    course = $(this).data 'id'
    $.ajax
      url: '/deregister_course.json',
      type: 'DELETE',
      data:
        course_id: course
      success: ->
          populateSchedule()
          populateCourseList()
          populateAuditList()

  populateFacultyList()
  populateCourseList()
  populateSchedule()
  populateAuditList()
