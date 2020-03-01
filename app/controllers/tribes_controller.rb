class TribesController < ApplicationController
  def index
    @tribes = Tribe.all
  end

  def new
    @tribe = Tribe.new
  end

  def create
    @tribe=Tribe.new(tribe_params)
    @tribe.save
    redirect_to tribe_path(@tribe)
  end

  def show
    @tribe=Tribe.find(params[:id])
    @user= User.find(session[:user_id])
  end

  def edit
    @tribe=Tribe.find(params[:id])
  end

  def update
    @tribe=Tribe.find(params[:id])
    @tribe.update(tribe_params)
    @tribe.save
    redirect_to tribe_path(@tribe)
  end

  

  private

  def tribe_params
    params.require(:tribe).permit(:name, :image_url, :url, :image )
    end

   

end
