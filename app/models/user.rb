# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  encrypted_password :string(255)
#

class User < ActiveRecord::Base
	attr_accessor :password
  attr_accessible :email, :name, :password, :password_confirmation
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name, :presence => true, 
  															:length => { :maximum => 20}
  validates :email, :presence => true,
  															:format => {:with => email_regex},
  															:uniqueness => {:case_sensitive => false}
  															
	validates :password, :presence => true,
																			:confirmation => true,
																			:length => {:within => 6..20}

  before_save :encrypt_password  
	
	class << self
		#method for session_controller
		def authenticate(email, submitted_password)
			user = find_by_email(email)
			(user && user.has_password?(submitted_password)) ? user : nil
		end
		#method for sessions_helper
		def authenticate_with_salt(id, cookies_salt) 
			user = find_by_id(id)
			(user && user.salt == cookies_salt) ? user : nil
		end
	end
	
  #--------encrypt password algorithm-----------------
  def has_password?(submitted_password)
  	encrypted_password == encrypt(submitted_password)
  end
  
  private 
  	def encrypt_password
  		self.salt = make_salt if new_record? 
  		self.encrypted_password = encrypt(password)
  	end
  	
  	def encrypt(string)
  		secure_hash("#{salt}--#{string}")
  	end
  	
  	def make_salt
  		secure_hash("#{Time.now.utc}--#{password}")
  	end
  	
  	def secure_hash(string)
  		Digest::SHA2.hexdigest(string)
  	end
  #---------end encrypt---------------------
end
