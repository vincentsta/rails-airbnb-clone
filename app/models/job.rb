class Job < ApplicationRecord
  belongs_to :company
  has_many :job_requests
  has_many :users, through: :job_requests
  validates :title, presence: true, uniqueness: { scope: :company, message: "Ce job existe déjà dans votre société" }
  validates :start_date, :end_date, presence: true

  serialize :extra_data, JSON

  mount_uploader :image, PhotoUploader

  geocoded_by :location
  after_validation :geocode, if: :location_changed?

end
