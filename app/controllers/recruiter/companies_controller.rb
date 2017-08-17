class Recruiter::CompaniesController < ApplicationController
  def show

    @user = User.find(params[:id])
    @company = @user.companies.first

    if params[:id].to_i == current_user.id && @user.is_candidate == false
    else
      redirect_to root_path
    end
  end

end
