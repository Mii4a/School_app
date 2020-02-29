class User < ApplicationRecord
    attr_accessor :remember_token
    before_save :downcase_email
    validates :name, presence: true,
                     length:   { maximum: 25,
                                 message: '25文字以下で入力してください' }
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
                         allow_nil: true,
                         length: { minimum: 6,
                                   message: "６文字以上入力してください"}
    
    class << self
        
    # 渡された文字列のハッシュ値を返す
    def digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    # ランダムなトークンを返す
    def new_token
        SecureRandom.urlsafe_base64
    end
    end
    
    # 永続セッションのためにユーザーをデータベースに記憶する
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end
    
    def authenticated?(attribute, token)
        digest = self.send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end
    
    def forget
        self.update_attribute(:remember_digest,nil)
    end
    private
    
    def downcase_email
        email.downcase!
    end
end

