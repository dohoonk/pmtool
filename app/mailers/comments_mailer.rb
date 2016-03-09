class CommentsMailer < ApplicationMailer
  def notify_discussion_owner(comment)
  @user = comment.user
  @discussion = comment.discussion
  mail(to: @discussion.user.email, subject: "#{@user.first_name} commented on your post")
  end
end
