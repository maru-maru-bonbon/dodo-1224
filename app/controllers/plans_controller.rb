class PlansController < ApplicationController
  before_action :move_to_index, except:  [:index, :show]


  def index
    @plans =Plan.all.order("created_at DESC")
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      @plan.plan_users.create(user_id: current_user.id)
      redirect_to root_path
    else 
      render :new
    end
  end





  private

  def plan_params
    params.require(:message).permit(
      :image,
      :name,
      :description,
      :item,
      :category_id,
      :term_id,
      :price_id).
      merge(user_id: current_user.id)
  end


  def move_to_index
    unless user_signed_in?
      redirect_to action: :index     
    end
  end
 
end
