class User < ApplicationRecord
    has_many :schools, dependent: :destroy
    has_many :school_relationships, foreign_key: "student_id", dependent: :destroy
    has_many :entered_schools, through: :school_relationships, source: :school
    has_many :school_chats, dependent: :destroy
    has_many :active_relationships, class_name: "UserRelationship", foreign_key: "follower_id", dependent: :destroy
    has_many :passive_relationships, class_name: "UserRelationship", foreign_key: "followed_id"
    has_many :following, through: :active_relationships, source: :followed
    has_many :follower, through: :passive_relationships, source: :follower
    has_many :retweets, dependent: :destroy
    has_many :retweeting, through: :retweets, source: :school
    attr_accessor :remember_token, :activation_token, :reset_token
    before_save :downcase_email
    before_create :create_activation_digest
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
    
    def activate
        update_columns(activated: true, activated_at: Time.zone.now)
    end
    
    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end
    
    def create_reset_digest
        self.reset_token = User.new_token
        update_columns(reset_digest: User.digest(reset_token),
                       reset_sent_at: Time.zone.now)
    end
    
    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end
    
    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end
    
    def feed
        following_ids = "SELECT followed_id FROM user_relationships 
                         WHERE follower_id = :user_id"
        retweeting_ids = "SELECT school_id FROM retweets 
                          WHERE user_id = :user_id"
        School.where("user_id IN (#{following_ids}) OR 
                      id IN (#{retweeting_ids}) OR 
                      user_id = :user_id", user_id: id)
    end
    
    def myfeed
        retweeting_ids = "SELECT school_id FROM retweets WHERE user_id = :user_id"
        School.where("id IN (#{retweeting_ids}) OR 
                      user_id = :user_id", user_id: id).reorder(updated_at: :desc)
    end
    
    def enter(school)
      entered_schools << school
    end
    
    def graduate(school)
        school_relationships.find_by(school_id: school.id).destroy
    end
    
    def entered?(school)
        entered_schools.include?(school)
    end
    
    def follow(other_user)
        following << other_user
    end
    
    def unfollow(other_user)
        active_relationships.find_by(followed_id: other_user.id).destroy
    end
    
    def followed?(other_user)
        following.include?(other_user)
    end
    
    def retweet(school)
        retweeting << school
    end
    
    def unretweet(school)
        retweets.find_by(school_id: school.id).destroy
    end
    
    def retweeted?(school)
        retweeting.include?(school)
    end
    
    private
    
    def downcase_email
        email.downcase!
    end
    
    def create_activation_digest
        self.activation_token = User.new_token
        self.activation_digest = User.digest(activation_token)
    end
end

