class Admin::UsersController < ApplicationController
  def index
    authenticate_admin
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    if !authenticate_admin
      return
    else
      @user.destroy
      flash[:notice] = "User #{@user.email} deleted"
      redirect_to admin_users_path
    end
  end
end
