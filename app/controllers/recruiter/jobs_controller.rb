class Recruiter::JobsController < ApplicationController

  def new
    @company = Company.find(params[:company_id])
    @job = Job.new
  end

  def create
    raise
    @job = Job.new(job_params)
    @job.save
    redirect_to recruiter_company_path(current_user.companies.first)
  end

  def edit
    @company = Company.params([:company_id])
    @job = Job.find(params[:id])
  end

  def update
    @job.update(job_params)
    redirect_to restaurant_path(@restaurant)
  end

  private


  def job_params
    params.require(:job).permit(:title, :start_date, :end_date, :monthly_salary, :description, :profile, :company_id, :category, :location, :image)
  end

end
