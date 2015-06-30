class LessonsController < ApplicationController
  def index
    @lessons = Lesson.all.sort_by {|obj| obj.number}
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.number = Lesson.all.length + 1
    if @lesson.save
      flash[:notice] = "LESSON SAVED, BRUH"
      redirect_to lessons_path
    else
      render :new
    end
  end

  def show
    lessons = Lesson.all
    @lesson = Lesson.find(params[:id])
    @nextLesson = lessons.find_by(number: @lesson.number+1)
    @previousLesson = lessons.find_by(number: @lesson.number-1)

  end

  def destroy
    @lesson = Lesson.find(params[:id])
    @lesson.destroy
    redirect_to lessons_path
  end

  def update
    @lesson = Lesson.find(params[:id])
    if @lesson.update(lesson_params)
      sortedLessons = Lesson.all.sort_by {|obj| obj.number}
      sortedLessons.slice!(sortedLessons.index(@lesson))
      sortedLessons.insert( @lesson.number-1, @lesson)
      sortedLessons.each do |lesson|
        lesson.update(number: sortedLessons.index(lesson)+1)
      end
      redirect_to lessons_path
    else
      render :edit
    end
  end

  def edit
    @lesson = Lesson.find(params[:id])
  end

  # Lesson.all.forEach(lesson)
  #   lesson.number = Lesson.all.index(lesson)


  private
  def lesson_params
    params.require(:lesson).permit(:name, :language, :content, :number)
  end

end
