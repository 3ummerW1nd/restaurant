class CommentsController < ApplicationController
  def create
    if session[:user_token]
      user_id = $redis.get(session[:user_token])
      @comment = Comment.create(comment_params)
      @comment.restaurant_id = params[:id]
      @comment.user_id = user_id
      @comment.upvote = 0
      if @comment.save
        redirect_to restaurant_url params[:id]
      else
        p 'fail'
      end
    else
      redirect_to restaurants_path
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :price, :headcount, :image, :tasted)
  end

end
