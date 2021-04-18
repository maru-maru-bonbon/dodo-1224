class RoomsController < ApplicationController

  def show
    @room = Room.find(params[:id])
    if RoomUser.where(:user_id => current_user.id, :room_id => @room.id).present?
      @direct_messages = @room.direct_messages
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
      room = Room.find(params[:id])
      room.destroy
      redirect_to users_rooms_path
  end
end
