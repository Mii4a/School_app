class School < ApplicationRecord
  belongs_to :user
  has_many :school_relationships, foreign_key: "school_id", dependent:   :destroy
  has_many :students, through: :school_relationships, source: :student
  has_many :school_chats, class_name: "SchoolChat", dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :retweeted_users, through: :retweets, source: :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :sub_title, length: { maximum: 60 }, allow_nil: true
  validates :name, presence: true, length: { maximum: 25 }
  validates :content, length: { maximum: 300 }, allow_nil: true
  
  def is_student?(student)
    students.include?(student)
  end
  
  private
  
    def picture_size
      if picture.size > 5.megabytes
        error.add(:picture, "5MB以下の写真のみ使用できます")
      end
    end
    
end
