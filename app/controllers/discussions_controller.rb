class DiscussionsController < ApplicationController
  before_action :find_discussion, only: [:show,:edit,:update,:destroy]

  def new
    @discussion = Discussion.new
  end

  def create
    @discussion = Discussion.new params_discussion
    @discussion.user_id = current_user.id
    if @discussion.save
      redirect_to discussions_path, notice: "Discussion created"
    else
      render :new
    end
  end

  def index
    @discussions = Discussion.all
  end

  def show
    @comment = Comment.new
    @comments = Comment.where("discussion_id = ?", @discussion.id)
  end

  def edit
    redirect_to root_path, alert: "access denied" unless can? :edit, @discussion
  end

  def update
    redirect_to root_path, alert: "access denied" unless can? :update, @discussion
    if @discussion.update params_discussion
      redirect_to discussions_path(@discussion)
    else
      render :edit
    end
  end

  def destroy
    redirect_to root_path, alert: "access denied" && return unless can? :destroy, @discussion
    @discussion.destroy
    redirect_to discussions_path
  end


  private

  def params_discussion
    params_discussion = params.require(:discussion).permit(:title,:body,:description)
  end

  def find_discussion
    @discussion = Discussion.find params[:id]
  end

end
