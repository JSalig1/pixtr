class CommentsController < ApplicationController
  
  def show
    
  end
  
  def create
    
    
    image = Image.find(params[:image_id])
    # current_user.comments.create(comment_params) #can also go this way....
    comment = image.comments.new(comment_params) # can also use: comment = image.comments.build(comment_params)
    if comment.save
      redirect_to image, notice: "Comment added!" # can also use alert: in place of notice:
    else
      redirect_to image, alert: "Can not comment with an empty comment."  # can also use notice: in place of alert:
    end
    
  end
  
  
  
  
  
  private
  
  def comment_params #whitelisting attributes to avoid forbidden attributes error! called Strong Params.
    
    # params.require(:comment).permit(:body) need user id via method below
    
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end
  
end