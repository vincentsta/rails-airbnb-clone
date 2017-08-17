class Company < ApplicationRecord
  belongs_to :user
  has_many :jobs
  has_many :job_requests, through: :jobs

  validates :name, presence: true, uniqueness: true
  validates :user, presence: true
  validate :user_is_not_a_candidate
  validates :industry, presence: true

  geocoded_by :location
  after_validation :geocode, if: :location_changed?

  mount_uploader :picture, PhotoUploader
  mount_uploader :logo, PhotoUploader

  def user_is_not_a_candidate
    if user.nil? || user.is_candidate
      errors.add(:user, "can't be a candidate")
      return false
    end
    return true
  end

end
