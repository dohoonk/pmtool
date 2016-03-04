class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project =  Project.new
  end

  def create
    params_project = params.require(:project).permit(:title,:description,:due_date)
    @project = Project.new params_project
    @project.user_id = current_user.id
    if @project.save
      redirect_to projects_path, notice: "Project Created"
    else
      render :new
    end
  end

  def show
    @project = Project.find params[:id]
    @tasks = Task.where("project_id = ?", params[:id])
  end

  def edit
    @project = Project.find params[:id]
  end

  def update
    @project = Project.find params[:id]
    params_project = params.require(:project).permit(:title,:description,:due_date)
    @project.update params_project
    if @project.save
      redirect_to projects_path, notice: "Project Edited"
    else
      render :new
    end
  end

  def destroy
    @project = Project.find params[:id]
    @project.destroy
    redirect_to projects_path
  end
end
