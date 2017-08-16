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
    @jobs = @jobs.sort_by {|job| job.title}
    jobs_categories
    @j_ids = @jobs.map { |job| job.id } || [0]
  end


  def show
    @job_request = JobRequest.new
  end

  def filter
    search_for_index(filter_jobs_params)
    jobs_categories
    @j_ids = @jobs.map { |job| job.id } || [0]

    previous_ids = filter_jobs_params[:job_ids].split(" ") || [0]
    previous_jobs = previous_ids.map { |id| Job.find(id.to_i) } || []

    @new_jobs = @jobs.reject { |job| previous_jobs.include?(job) } || []
    suppr_jobs = previous_jobs.reject { |job| @jobs.include?(job) } || []
    @suppr_jobs_id = suppr_jobs.map { |job| job.id } || [0]

    if previous_jobs.nil? || previous_jobs.length == 0
      render :index
    else
      respond_to do |format|
        format.html
        format.js  # <-- idem
      end
    end
  end

  private

  def set_job
   @job = Job.find(params[:id])
  end

  def jobs_categories
    # definit les categories de job pour afficher dans les filtres
    @categories = Job.select(:category).distinct.map do |job|
      job.category
    end
  end


  def jobs_params
    params.permit(:location, :start_date, :end_date)
  end

  def filter_jobs_params
    params.require(:query).permit(:location, :start_date, :end_date, :job_ids)
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
