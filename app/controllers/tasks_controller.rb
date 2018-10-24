class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :owners_only, only: [:show, :edit, :update, :destroy]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
   @tasks = current_user.tasks.order(created_at: :desc).where(project_id: nil)
   @task = current_user.tasks.new
  end
  
  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    respond_to do |format|
      if @task.save
        #redirect_to tasks_path, notice: 'Task added'
        format.js
      else
        #render :new
        format.js
      end
    end
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html {redirect_to tasks_path}
        format.js
      else
        format.html {render :edit}
        format.js
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html {redirect_to root_path}
      format.js
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :status, :project_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def owners_only
    set_task
    if current_user != @task.user
      redirect_to tasks_path
    end
  end
end
