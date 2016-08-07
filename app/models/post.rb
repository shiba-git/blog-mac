class Post < ActiveRecord::Base
  belongs_to :user
  #validates :user_id, presences: true
  validates :title, presence: true
  validates :description, presence: true, length: { maximum: 1000 }
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validate :picture_size

    private

    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
