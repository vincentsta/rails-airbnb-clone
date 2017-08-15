class JobsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :index, :show]
  layout 'home_layout', only: [ :home ]


  def home
    # TODO: filtrer suivant les jobs a afficher sur la home
    @jobs = Job.all
  end

  def index
    # TODO: filtrer suivant query de la home params = location / start_date / end_date
    location = jobs_params[:location]
    @jobs = Job.where("location ILIKE ?", "%#{location}")
   

  end

  def job
    @job = Job.find(params[:id])
    @company = @job.company
    @job_r = JobRequest.new
  end

  private

  def jobs_params
  params.permit(:location, :start_date, :end_date)
  end

end
