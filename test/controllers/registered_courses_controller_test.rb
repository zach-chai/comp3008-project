require 'test_helper'

class RegisteredCoursesControllerTest < ActionController::TestCase
  setup do
    @registered_course = registered_courses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:registered_courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create registered_course" do
    assert_difference('RegisteredCourse.count') do
      post :create, registered_course: { course_id: @registered_course.course_id, grade: @registered_course.grade, user_id: @registered_course.user_id }
    end

    assert_redirected_to registered_course_path(assigns(:registered_course))
  end

  test "should show registered_course" do
    get :show, id: @registered_course
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @registered_course
    assert_response :success
  end

  test "should update registered_course" do
    patch :update, id: @registered_course, registered_course: { course_id: @registered_course.course_id, grade: @registered_course.grade, user_id: @registered_course.user_id }
    assert_redirected_to registered_course_path(assigns(:registered_course))
  end

  test "should destroy registered_course" do
    assert_difference('RegisteredCourse.count', -1) do
      delete :destroy, id: @registered_course
    end

    assert_redirected_to registered_courses_path
  end
end
