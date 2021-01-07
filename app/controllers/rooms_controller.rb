class RoomsController < ApplicationController
  def new
    @room = Room.new
  end
  
  def create
    @room = Room.new(room_params)
    @room.save
    redirect_to room_path(@room.id)
  end
  
  def index
    @rooms = Room.all
  end
  
  def show
    @room = Room.find(params[:id])
  end
  
end

private

 def room_params
   params.require(:room).permit(:name, :image, :introduction, :zipcode, :address, :phone_number)
 end
