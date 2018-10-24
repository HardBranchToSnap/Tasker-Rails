class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :owners_only, only: [:show, :edit, :update, :destroy]
  #before_action :set_project, only: [:show, :edit, :update, :destroy]
  
  respond_to :js

  def index
    @projects = current_user.projects.all
  end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      redirect_to project_path(@project), notice: 'Project created'
    else
      render :new
    end
  end

  # def edit; end

  # def update
  #   respond_to do |format|
  #     if @project.update(project_params)
  #       format.js
  #     else
  #       format.js
  #     end
  #   end
  # end

  def show
    @task = Task.create(project_id: @project.id)
    @message = Message.create
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def owners_only
    set_project
    if current_user != @project.user
      redirect_to '/'
    end
  end
end