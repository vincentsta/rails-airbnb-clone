class JobRequestsController < ApplicationController
  
	# def new
	# 	@job = Job.find(params[:id])
 #  	@job_request = Job_request.new(job_request_params)
	# end

	def create
  
	@user = current_user
	@job_request = JobRequest.new
	@job = Job.find(params[:job_id])
	@job_request.job_id = @job.id
	@job_request.user_id = @user.id
	# @job_request.save

	if @job_request.save
		flash[:notice] = "Ta candidature au poste de #{@job_request.job.title} a bien été transmise à #{@job_request.job.company.name}"
		redirect_to jobs_path
	else
		render "jobs/show"
	end

	end

	def job_request_params
    params.require(:job_request).permit(:job_id, :user_id, :current_status, :message)
  end

end
