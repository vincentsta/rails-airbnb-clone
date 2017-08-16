class Recruiter::CompaniesController < ApplicationController
  def show

    @company = Company.find(params[:id])
     #   if params[:id].to_i == current_user.id && @user.is_candidate == false

  #   else
  #     redirect_to jobs_path
  #   end
  # end
  end
end
