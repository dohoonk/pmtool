class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @project = Project.find params[:project_id]
    @task = Task.new
  end

  def create
    params_task = params.require(:task).permit(:title,:due_date,:body,:project_id,:done)
    @task = Task.new params_task
    @task.project_id = params[:project_id]
    if @task.save
      redirect_to project_path(params[:project_id])
    else
      render :new
    end
  end

  def show
    @project = Project.find params[:project_id]
    @task = Task.find params[:id]
  end

  def edit
    @task = Task.find params[:id]
  end

  def update
    params_task = params.require(:task).permit(:title, :due_date, :body, :project_id, :done)
    @task = Task.find params[:id]
    @task.project_id = params[:project_id]
    if @task.update params_task
      redirect_to task_path(@task)
    else
      render :new
    end
  end

  def destroy
    @project = Project.find params[:project_id]
    @task = Task.find params[:id]
    @task.destroy
    redirect_to project_path(@project)
  end

  def done
    @project = Project.find params[:project_id]
    @task = Task.find params[:id]
    if @task.done
    @task.done = false
    @task.save
    redirect_to project_path(@project)
    else
    @task.done = true
    @task.save
    redirect_to project_path(@project)
    end
  end

end
