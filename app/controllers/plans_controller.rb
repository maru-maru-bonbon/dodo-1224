class PlansController < ApplicationController


  def index
    @plans =Plan.all.order("created_at DESC")
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

 
end
