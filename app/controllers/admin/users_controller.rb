# app/controllers/admin/users_controller.rb
class Admin::UsersController < ApplicationController
    # Ensure only admins can access these routes
    before_action :authenticate_admin!
  
    # Show a list of all users
    def index
      @users = User.all
    end
  
    # Show details of a single user
    def show
      @user = User.find(params[:id])
    end
  
    # Render a form to create a new user
    def new
      @user = User.new
    end
  
    # Create a new user based on form parameters
    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_users_path, notice: 'User created successfully.'
      else
        render :new
      end
    end
  
    # Delete a specific user
    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_users_path, notice: 'User deleted successfully.'
    end
  
    private
  
    # Strong parameters to allow only permitted attributes
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end
  