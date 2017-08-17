class UsersController < ApplicationController

  def show

    @user = User.find(params[:id])
    # raise
    if params[:id].to_i == current_user.id && @user.is_candidate

    else
      redirect_to root_path
    end
  end

end
