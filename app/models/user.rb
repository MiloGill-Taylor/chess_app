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

	private
		def downcase_email
			self.email = self.email.downcase 
		end 
end
