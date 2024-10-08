class User < ApplicationRecord
	has_one :artist, dependent: :destroy
	has_one :listener, dependent: :destroy
	has_many :active_relationships, class_name: "Relationship",
																	foreign_key: "follower_id",
																	dependent: :destroy
	has_many :following, through: :active_relationships, source: :followed

	has_many :passive_relationships, class_name: "Relationship",
																	 foreign_key: "followed_id",
																	 dependent: :destroy
	has_many :followers, through: :passive_relationships, source: :follower
	attr_accessor :remember_token
	before_save { self.email = email.downcase }
	validates :username, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 244 },
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: true
	has_secure_password
	validates :password, presence: true, length: {minimum: 6 }, allow_nil: true

	def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
		remember_digest
	end

	def session_token
		remember_digest || remember
	end

	def authenticated?(remember_token)
		return false if remember_digest.nil?
		Bcrypt::password.new(remember_digest).is_password?(remember_token)
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	def artist?
		self.is_artist == true
	end

	def listener?
		self.is_artist == false
	end
	
	#フォローする
	def follow(other_user)
		following << other_user unless self == other_user #if other_user.artist && self.listener
	end

	#フォロー解除
	def unfollow(other_user)
		following.delete(other_user)
	end

	#　現在のユーザーがアーティストをフォローしていればtrueを返す
	def following?(other_user)
		following.include?(other_user)
	end
end
