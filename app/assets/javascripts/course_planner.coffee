
$(document).on 'ready page:load', ->
  populateFacultyList = ->
    $("#faculty-list button").remove()
    $.get "/faculties.json"
    .done (data) ->
      for faculty in data
        $("#faculty-list").append "<button type=\"button\" class=\"list-group-item\" data-faculty=\"#{faculty.code}\">#{faculty.name}</button>"

  populateCourseList = (faculty = null) ->
    $("#course-list button").remove()
    $.get "/courses.json?faculty=#{faculty}"
    .done (data) ->
      for course in data
        $("#course-list").append "<button type=\"button\" class=\"list-group-item\" data-course=\"#{course.code}\">#{course.name}</button>"

  $("#faculty-list").on "click", "button", ->
    faculty = $(this).data 'faculty'
    populateCourseList(faculty)

  $(".course").click ->
    course = $(this).data 'course'
    $("tr").removeClass 'selected'
    $("tr.#{course}").addClass 'selected'
    $.get "/exams.json?course=#{course}"
    .done (data) ->
      populateExams data

  populateFacultyList()
