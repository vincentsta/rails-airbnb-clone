class JobRequestsController < ApplicationController

   before_action :set_job_request, only: [:edit, :update ]  

  def create
	  @user = current_user
  	@job_request = JobRequest.new(job_request_params)
    @job = Job.find(params[:job_id])
  	@job_request.job_id = @job.id
  	@job_request.user_id = @user.id


    if @job_request.save
      flash[:notice] = "Ta candidature au poste de #{@job_request.job.title} a bien été transmise à #{@job_request.job.company.name}"
      redirect_to jobs_path
    else
      render "jobs/show"
    end
  end
  
  def edit
    @job = @job_request.job
  end

  def update
    @job = @job_request.job
    @job_request.update(job_params)
    redirect_to recruiter_company_path(@job.company)
  end

   private

  def job_params
    params.require(:job_request).permit(:current_status)
  end

  def set_job_request
    @job_request = JobRequest.find(params[:id])
  end

	def job_request_params
    params.require(:job_request).permit(:current_status, :message)
  end

end

