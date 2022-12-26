class RepliesController < ApplicationController
  def create
    if session[:user_token]
      user_id = $redis.get(session[:user_token])
      @reply = Reply.create(reply_params)
      @reply.user_id = user_id
      @reply.comment_id = params[:comment_id]
      if @reply.save
        redirect_to restaurant_url params[:id]
      else
        p 'fail'
      end
    else
      redirect_to restaurants_path
    end
  end

  private
  def reply_params
    params.require(:reply).permit(:reply, :comment_id)
  end
end
