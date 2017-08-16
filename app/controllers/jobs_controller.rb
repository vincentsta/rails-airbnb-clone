class JobsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :index, :show, :filter]
  layout 'home_layout', only: [ :home ]
  before_action :set_job, only: [:show]

  def home
    # TODO: filtrer suivant les jobs a afficher sur la home
    @jobs = Job.all.sample(3)
  end

  def index
    search_for_index(jobs_params)
  end


  def show
    @job_request = JobRequest.new

  end
  
  def filter
    search_for_index(filter_jobs_params)
  end

  private

  def set_job
   @job = Job.find(params[:id])
  end

  def jobs_params
    params.permit(:location, :start_date, :end_date)
  end

  def filter_jobs_params
    params.require(:query).permit(:location, :start_date, :end_date)
  end

  def search_for_index(params)
    location_string = params[:location]
    location = location_string unless location_string.nil? || location_string.length == 0
    # Recuperation des dates et passage de string en format date
    sdate_string = params[:start_date]
    sdate = Date.parse(sdate_string) unless sdate_string.nil? || sdate_string.length == 0
    edate_string = params[:end_date]
    edate = Date.parse(edate_string) unless edate_string.nil? || edate_string.length == 0
    jobs = location ? Job.where("location ILIKE ?", "%#{location}") : Job.all
    jobs_filtered_by_dates =  []
    jobs.each do |job|
      jobs_filtered_by_dates << job if (sdate.nil? || job.start_date > sdate) && (edate.nil? || job.end_date < edate)
    end
    @jobs = jobs_filtered_by_dates
    @search = {location: location, start_date: sdate, end_date: edate}
  end
end
