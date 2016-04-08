class RegisteredCoursesController < ApplicationController
  before_action :set_registered_course, only: [:show, :edit, :update, :destroy]

  # GET /registered_courses
  # GET /registered_courses.json
  def index
    @registered_courses = RegisteredCourse.all
  end

  # GET /registered_courses/1
  # GET /registered_courses/1.json
  def show
  end

  # GET /registered_courses/new
  def new
    @registered_course = RegisteredCourse.new
  end

  # GET /registered_courses/1/edit
  def edit
  end

  # POST /registered_courses
  # POST /registered_courses.json
  def create
    @registered_course = RegisteredCourse.new(registered_course_params)

    # hack for single user
    @registered_course.user_id = User.first.id

    respond_to do |format|
      if @registered_course.save
        format.html { redirect_to @registered_course, notice: 'Registered course was successfully created.' }
        format.json { render :show, status: :created, location: @registered_course }
      else
        format.html { render :new }
        format.json { render json: @registered_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registered_courses/1
  # PATCH/PUT /registered_courses/1.json
  def update
    respond_to do |format|
      if @registered_course.update(registered_course_params)
        format.html { redirect_to @registered_course, notice: 'Registered course was successfully updated.' }
        format.json { render :show, status: :ok, location: @registered_course }
      else
        format.html { render :edit }
        format.json { render json: @registered_course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registered_courses/1
  # DELETE /registered_courses/1.json
  def destroy
    @registered_course.destroy
    respond_to do |format|
      format.html { redirect_to registered_courses_url, notice: 'Registered course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_by_course
    Course.find(params[:course_id]).registered_courses.first.destroy
    respond_to do |format|
      format.html { redirect_to registered_courses_url, notice: 'Registered course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registered_course
      @registered_course = RegisteredCourse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def registered_course_params
      params.require(:registered_course).permit(:user_id, :course_id, :grade)
    end
end
