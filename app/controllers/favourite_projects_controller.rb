class FavouriteProjectsController < ApplicationController
  before_action :authenticate!

  def create
    @project = Project.find params[:project_id]
    redirect_to project_path(@project), alert: "You can not like the post twice!" and return if current_user.favourite_projects.find_by_project_id params[:project_id]
    @favourite_project = current_user.favourite_projects.new
    # @favourite_project = FavouriteProject.new
    @favourite_project.project_id = @project.id
    if @favourite_project.save
      redirect_to project_path(@project), alert: "Project Favourited"
      # @favourite_project.user_id = current_user.id
      # @favourite_project.project_id = @project.id
      # @favourite_project.save
    else
      redirect_to project_path(@project), alert: "Can't favourte"
    end
  end

  def destroy
    @favourite_project = current_user.favourite_projects.find_by_project_id params[:project_id]
    @project = params[:project_id]
    # @favourite_project = FavouriteProject.where("project_id = ? AND user_id = ?", @project.id, current_user.id)
    @favourite_project.destroy
    redirect_to project_path(@project), alert: "Unfavourited"
  end
end
