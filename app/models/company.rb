class Company < ApplicationRecord
  belongs_to :user
  has_many :jobs
  has_many :job_requests, through: :jobs

  validates :name, presence: true, uniqueness: true
  validates :user, presence: true
  validate :user_is_not_a_candidate
  # TODO: validates :location, presence: true
  validates :industry, presence: true
  # TODO: gerer des categories d industries
  #mount_uploader :picture, PictureUploader
  #mount_uploader :logo, LogoUploader

  def user_is_not_a_candidate
    if user.nil? || user.is_candidate
      errors.add(:user, "can't be a candidate")
      return false
    end
    return true
  end

end
