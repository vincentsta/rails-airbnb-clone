class JobRequest < ApplicationRecord
  belongs_to :job
  belongs_to :user
  validates :user, uniqueness: { scope: :job,
    message: "Un candidat ne peut postuler qu'une seule fois à un job " }
  validates :user, presence: true
  validate :user_is_a_candidate

  def user_is_a_candidate
    if user.nil? || !user.is_candidate
      errors.add(:user, "must be a candidate")
      return false
    end
    return true
  end


end
