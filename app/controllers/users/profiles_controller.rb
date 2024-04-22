class Users::ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[ edit update]

  def index
  end

  def edit
  end

  def update
     # Attempt to update the user's profile.
     if @user.update(profile_params)
      # If successful, redirect to a relevant page with a success message.
      flash[:notice] = "Profile updated successfully."
      redirect_to users_profile_path(@user)
    else
      # If errors, re-render the form with the error messages.
      flash.now[:alert] = "There was an error updating your profile. Please check the form for errors."
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  # Strong parameter method to permit only the necessary fields.
  def profile_params
    params.require(:user).permit(:username, :full_name)
  end

end