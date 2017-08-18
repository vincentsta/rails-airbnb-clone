class JobLoader < ApplicationRecord

  mount_uploader :logo, PhotoUploader
  mount_uploader :img, PhotoUploader

end
