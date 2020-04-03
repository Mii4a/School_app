class SchoolChat < ApplicationRecord
  belongs_to :user
  belongs_to :school
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :school_id, presence: true
end
