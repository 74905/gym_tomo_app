class RoomsController < ApplicationController
  before_action :authenticate_user!
  def new
    @room = Room.new
  end
  
  def create
    @room = Room.new(room_params)
    if @room.save
      flash[:notice] = "ジムが作成されました！"
      redirect_to room_path(@room.id)
    else
      render :new
    end
  end
  
  def index
    @rooms = Room.page(params[:page]).reverse_order
  end
  
  def show
    @room = Room.find(params[:id])
  end
  
  def searchs
    @search = params[:search]
    rooms = Room.search(params[:search])
    @rooms = rooms.page(params[:page]).reverse_order
  end
  
  def participants
    @room = Room.find(params[:id])
    @user_rooms = @room.user_rooms
  end 
  
end

private

 def room_params
   params.require(:room).permit(:name, :image, :introduction, :zipcode, :address, :phone_number)
 end
