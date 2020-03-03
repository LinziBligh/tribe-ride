class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user=User.new(user_params)
    @user.save
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end

  def facebook_create
    @user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.name = auth['info']['name']
      u.email = auth['info']['email']
      u.password = SecureRandom.urlsafe_base64
    end
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end


  def show
    @user=User.find(params[:id])
    @rides = @user.member_and_participating
    @rides_sorted = @rides.sort_by { |r| r['date'] }
    
  end


  def update
    @user=User.find(session[:user_id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end


  def edit
    @user=User.find(session[:user_id])
  end

  
  private

  def user_params
  params.require(:user).permit(:name, :password, :email, :peloton_name, :admin, :uid)
  end

  def auth
    request.env['omniauth.auth']
  end

end
