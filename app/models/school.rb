class School < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :sub_title, length: { maximum: 60 }
  validates :name, presence: true, length: { maximum: 25 }
end
