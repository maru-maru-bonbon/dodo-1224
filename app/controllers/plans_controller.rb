class PlansController < ApplicationController
  before_action :move_to_index, except:  [:index, :show]
  before_action :set_plan,only: [:show, :edit, :update, :destroy]


  def index
    @plans =Plan.all.order("created_at DESC")
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      @plan.participants.create(user_id: current_user.id)
      redirect_to root_path
    else 
      render :new
    end
  end

  def show
  end

  def edit
    if current_user.id != @plan.user.id
      redirect_to root_path
    end
  end

  def update
    if @plan.update(plan_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @plan.destroy 
      redirect_to root_path
    else
      render :show
    end
  end


  private

  def plan_params
    params.require(:plan).permit(
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

  def set_plan
    @plan = Plan.find(params[:id])
  end
 
end
