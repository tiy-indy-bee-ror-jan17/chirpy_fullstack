class CommentsController < ApplicationController

  before_action :require_user

  def create
    if params[:user_id]
      @object = User.find(params[:user_id])
    elsif params[:chirp_id]
      @object = Chirp.find(params[:chirp_id])
    elsif params[:comment_id]
      @object = Comment.find(params[:comment_id])
    end
    @comment = @object.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Commented!"
    else
      flash[:warning] = "You kinda need to leave a comment"
    end
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
