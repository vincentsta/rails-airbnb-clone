class Recruiter::CompaniesController < ApplicationController

  def show
    @user = current_user
    @company = Company.find(params[:id])
    @jobs = @company.jobs

    if @user.is_candidate == false
    else
      redirect_to root_path
    end
  end


end

  private


  def job_params
    params.require(:job).permit(:title, :start_date, :end_date, :monthly_salary, :description, :profile, :company_id, :category, :location, :image)
  end
