class User < ApplicationRecord
    validates :name, presence: true,
                     length: { maximum: 15,
                               message: '15文字以下で入力してください' }
    VALID_EMAIL_REGAX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true,
                      length: {maximum: 255 },
                      format: { with: VALID_EMAIL_REGAX },
                      uniqueness: { case_sensitive: false }
end
