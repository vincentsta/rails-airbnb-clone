class JobRequestsController < ApplicationController
  
	def new
		@job  = Job.find(params[:id])
  	@job_request = Job_request.new(job_request_params)
	end

	def create
  
  #TO DO avec un user = current_user en param en verifiant que c est un candidat
	@user = current_user
	@job_request.job = Job.find(params[:job_id])
	@job_request.save

	if @job_request.save
				flash[:notice] = "Votre application a bien ete transmise au recruteur"
				redirect_to jobs_path(@job)
			else
				render "jobs/show"
			end

	end

	def job_request_params
    params.require(:job_request).permit(:job_id, :user_id, :current_status, :message)
  end

end
