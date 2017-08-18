class JobsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :index, :show, :filter]
  layout 'home_layout', only: [ :home ]
  before_action :set_job, only: [:show]

  def home
    # TODO: filtrer suivant les jobs a afficher sur la home
    @jobs = Job.all.sample(3)
  end

  def index
    search_matching_jobs(jobs_params)
    sort_jobs_by_title
    retrieve_jobs_categories
    prepare_gmaps
    # @j_ids = @jobs.map { |job| job.id } || [0]
  end


  def show
    @job_request = JobRequest.new
  end

  def filter
    search_matching_jobs(filter_jobs_params)
    sort_jobs_by_title
    retrieve_jobs_categories
    prepare_gmaps
    # @j_ids = @jobs.map { |job| job.id } || [0]

    # previous_ids = filter_jobs_params[:job_ids].split(" ") || [0]
    # previous_jobs = previous_ids.map { |id| Job.find(id.to_i) } || []

    # @new_jobs = @jobs.reject { |job| previous_jobs.include?(job) } || []
    # suppr_jobs = previous_jobs.reject { |job| @jobs.include?(job) } || []
    # @suppr_jobs_id = suppr_jobs.map { |job| job.id } || [0]

    # if previous_jobs.nil? || previous_jobs.length == 0
    #   render :index
    # else
    #   respond_to do |format|
    #     format.html
    #     format.js  # <-- idem
    #   end
    # end
  end


  private

  def set_job
   @job = Job.find(params[:id])
  end

  def retrieve_jobs_categories
    # definit les categories de job pour afficher dans les filtres
    @categories = Job.select(:category).distinct.map do |job|
      job.category
    end
  end


  def jobs_params
    params.permit(:location, :start_date, :end_date)
  end

  def filter_jobs_params
    params.require(:query).permit(:location, :start_date, :end_date, :category, :min_salary)
  end

  def sort_jobs_by_title
    @jobs = @jobs.sort_by {|job| job.title}
  end

  def search_matching_jobs(params)
    @search = {}
    # Traitement des parametres
    params.each do |pkey, pvalue|
      unless pvalue.nil? || pvalue.length == 0
        if pkey.include?("date")
          p_ok = Date.parse(pvalue)
        elsif pkey.include?("salary")
          p_ok = pvalue.to_i
        else
          p_ok = pvalue
        end
        @search[pkey.to_sym] = p_ok
      end
    end
    # Filtres
    # Par location
    jobs_by_location = @search[:location] ? Job.where("location ILIKE ?", "%#{@search[:location]}") : Job.all
    # Par date
    sdate = @search[:start_date]
    edate = @search[:end_date]
    jobs_by_dates = jobs_by_location.select do |job|
      (sdate.nil? || job.start_date > sdate) && (edate.nil? || job.end_date < edate)
    end
    # Par categorie
    jobs_by_category = @search[:category].nil? ? jobs_by_dates : jobs_by_dates.select do |job|
      job.category == @search[:category]
    end
    # Par salaire mini
    @jobs = @search[:min_salary].nil? ? jobs_by_category : jobs_by_category.select do |job|
      job.monthly_salary >= @search[:min_salary]
    end
  end

  def prepare_gmaps
    @jobs = @jobs.reject { |job| job.latitude==nil && job.longitude==nil }

    @hash = Gmaps4rails.build_markers(@jobs) do |job, marker|
      marker.lat job.latitude
      marker.lng job.longitude
      marker.infowindow render_to_string(partial: "/jobs/map_box", locals: { job: job })
    end

  end
end
