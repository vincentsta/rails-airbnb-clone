class JobRequestsController < ApplicationController

   before_action :set_job_request, only: [:edit, :update ]

  def create
    #TO DO avec un user = current_user en param en verifiant que c est un candidat
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
end

