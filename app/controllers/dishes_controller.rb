class DishesController < ApplicationController
  skip_before_action :verify_authenticity_token,:only => :destroy

  def destroy
    dish = Dish.find(params[:id])
    restaurant_id = dish.restaurant_id
    owner_id = Restaurant.find(restaurant_id).owner_id
    if owner_id.to_s == $redis.get(session[:user_token])
      if dish
        dish.destroy
        dish_image_url = dish.image_url()
        if File.path(dish_image_url)
          File.delete(dish_image_url)
        end
      end
    end
  end

  def create
    restaurant = Restaurant.find params[:id]
    if session[:user_token]
      user_id = $redis.get(session[:user_token])
      if user_id && user_id == restaurant.owner_id.to_s
        @dish = Dish.create(dish_params)
        @dish.restaurant_id = params[:id]
        @dish.upvote = 0
        if @dish.save
          redirect_to edit_restaurant_url params[:id]
        else
          p 'fail'
        end
      else
        redirect_to restaurants_path
      end
    else
      redirect_to restaurants_path
    end
  end

  def upvote
    user_id = $redis.get(session[:user_token])
    dish = Dish.find_by(:id => params[:id])
    redis_like_key = user_id.to_s + '_like_dish'
    if $redis.scard(redis_like_key) && $redis.sismember(redis_like_key, params[:id])
      $redis.srem(redis_like_key, params[:id])
      dish.upvote -= 1;
    else
      $redis.sadd(redis_like_key, params[:id])
      dish.upvote += 1;
    end
    dish.save
  end

  private
  def dish_params
    params.require(:dish).permit(:name, :price, :image)
  end

end
