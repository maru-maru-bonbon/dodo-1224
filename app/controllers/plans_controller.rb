class PlansController < ApplicationController

  def index
    @plans =Plan.all.order("created_at DESC")
  end

end
