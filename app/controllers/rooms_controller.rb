class RoomsController < ApplicationController
  def index
    @user = current_user
    @currentRoomUser = current_user.room_users
    myRoomIds = []
    @currentRoomUser.each do |room_users|
      myRoomIds << room_users.room.id
    end
    @anotherRoomUser = RoomUser.where(room_id: myRoomIds).where.not(user_id: @user.id).order(created_at: :desc)
  end

  def show
    @room = Room.find(params[:id])
    if RoomUser.where(:user_id => current_user.id, :room_id => @room.id).present?
      @direct_messages = @room.direct_messages
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @room = Room.create(:name => "DM")
    @entry1 = RoomUser.create(:room_id => @room.id, :user_id => current_user.id)
    @entry2 = RoomUser.create(params.require(:entry).permit(:user_id, :room_id).merge(:room_id => @room.id))
    redirect_to room_path(@room.id)
  end

  def destroy
      room = Room.find(params[:id])
      room.destroy
      redirect_to users_rooms_path
  end
end
