class User < ApplicationRecord
	has_secure_password
	validates :name, 
			   presence: true, 
			   length: { maximum: 20 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, 
			   presence: true, 
			   format: { with: VALID_EMAIL_REGEX }, 
			   uniqueness: true,
			   length: { maximum: 255 }
	validates :password, 
			   presence: true, 
			   length: { minimum: 6 }
	before_validation :downcase_email

	def User.new_token
		SecureRandom.urlsafe_base64 # Random string
	end 

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
		                                              BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	def games
		Game.where('white_player_id = ? OR black_player_id = ?', self.id, self.id)
	end 

	def set_session_token
		token = User.new_token 
		self.update_attribute(:session_token, token)
		token
	end 

	# def authenticate(session_token)
	# 	return false if self.session_digest.nil?
	# 	BCrypt::Password.new(self.session_digest).is_password?(token) 
	# end 


	private
		def downcase_email
			self.email = self.email.downcase 
		end 
end
