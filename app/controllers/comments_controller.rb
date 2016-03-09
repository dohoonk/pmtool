class CommentsController < ApplicationController

  def new
    find_discussion
    @comment = Comment.new
  end

  def create
    find_discussion
    @comment = Comment.new params_comment
    @comment.discussion_id = @discussion.id
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to discussion_path(@discussion)
    else
      render :new
    end
  end

  def edit
    find_comment
    find_discussion
    redirect_to root_path, alert: "access deined" && return unless can? :edit, @comment
  end

  def update
    find_discussion
    find_comment
    redirect_to root_path, alert: "access denied" && return unless can? :update, @comment
    if @comment.update params_comment
      redirect_to discussion_path(@discussion)
    else
      render :edit
    end
  end

  def destroy
    find_discussion
    find_comment
    redirect_to root_path, alert: "access denied" && return unless can? :destroy, @comment
    @comment.destroy
    redirect_to discussion_path(@discussion)
  end

  private

  def params_comment
    params_comment = params.require(:comment).permit(:body,:discussion_id)
  end

  def find_comment
    @comment = Comment.find params[:id]
  end

  def find_discussion
    @discussion = Discussion.find params[:discussion_id]
  end
end
