class User < ApplicationRecord
    before_save { self.email = email.downcase }
    validates :name, presence: true,
                     length:   { maximum: 15,
                                 message: '15文字以下で入力してください' }
    VALID_EMAIL_REGAX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true,
                      length:     { maximum: 255 },
                      format:     { with: VALID_EMAIL_REGAX },
                      uniqueness: { case_sensitive: false }
    VALID_UNIQUE_NAME_REGAX = /\A[a-z0-9_]+\z/i
    validates :unique_name, presence:   true,
                            length:     { in: 5..15 }, 
                            format:     { with: VALID_UNIQUE_NAME_REGAX },
                            uniqueness: true
    has_secure_password
    validates :password, presence: true,
                         length: { minimum: 6,
                                   message: "５文字以上入力してください"}
    
  class << self
      
    private
    def downcase_email
        email.downcase!
    end
  end
end
