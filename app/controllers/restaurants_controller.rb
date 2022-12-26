class RestaurantsController < ApplicationController
  before_action :auth_user

  def edit
    restaurant = Restaurant.find params[:id]
    @dishes = Dish.where(:restaurant_id => params[:id])
    if session[:user_token]
      user_id = $redis.get(session[:user_token])
      if user_id && user_id == restaurant.owner_id.to_s
        @restaurant = restaurant
      else
        redirect_to restaurants_path
      end
    else
      redirect_to restaurants_path
    end
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.create(restaurant_param)
    @restaurant.upvote = 0
    @restaurant.owner_id = $redis.get(session[:user_token])
    if @restaurant.save
      flash[:notice] = "Create Successful!"
      redirect_to restaurants_list_path session[:user_token]
    else
      render action: :new
    end
  end

  def index
    @restaurants = Restaurant.page(params[:page] || 1).per_page(9).order("created_at desc")
  end

  def list
    user_id = $redis.get(session[:user_token])
    if User.find_by(:id => user_id)
      @restaurants = Restaurant.where(:owner_id => user_id).page(params[:page] || 1).per_page(9).order("created_at desc")
    else
      redirect_to new_session_url
    end
  end

  def show
    @restaurant = Restaurant.find params[:id]
    @comment = Comment.new
    @reply = Reply.new
    @comments = Comment.where(:restaurant_id => params[:id]).order("created_at desc").page(params[:comments_page] || 1).per_page(9)
    @dishes = Dish.where(:restaurant_id => params[:id]).order("upvote desc").page(params[:dishes_page] || 1).per_page(9)
  end

  def update
    @restaurant = Restaurant.find params[:id]
    if @restaurant.update(restaurant_param)
      #flash
    else
      #flash
    end
  end

  def upvote
    user_id = $redis.get(session[:user_token])
    restaurant = Restaurant.find_by(:id => params[:id])
    redis_like_key = user_id.to_s + 'like'
    if $redis.scard(redis_like_key) && $redis.sismember(redis_like_key, params[:id])
      $redis.srem(redis_like_key, params[:id])
      restaurant.upvote -= 1;
    else
      $redis.sadd(redis_like_key, params[:id])
      restaurant.upvote += 1;
    end
    restaurant.save
  end

  private
  def restaurant_param
    params.require(:restaurant).permit(:name, :intro, :address, :image)
  end

end
