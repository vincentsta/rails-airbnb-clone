class JobsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :index, :show]

  def home
    # TODO: filtrer suivant les jobs a afficher sur la home
    @jobs = Job.all
  end

  def index
    # TODO: filtrer suivant query de la home params = location / start_date / end_date
    @jobs = Job.all
  end

  def job
    @job = Job.find(params[:id])
    @company = @job.company
    @job_r = JobRequest.new
  end



end
