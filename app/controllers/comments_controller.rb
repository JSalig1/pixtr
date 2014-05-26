class CommentsController < ApplicationController
  def show
  end

  def create
    @image = Image.find(params[:image_id])
    @comment = @image.comments.new(comment_params)
    if @comment.save
      activity = Activity.new_activity(@comment, @image, current_user)
      notify_followers(@comment, @image)
    else
      redirect_to @image, alert: "Can not comment with an empty comment."
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end
end
