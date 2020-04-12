class Retweet < ApplicationRecord
    belongs_to :user
    belongs_to :school
    validates :user_id, presence: true
    validates :school_id, presence: true
    counter_culture :school
end
