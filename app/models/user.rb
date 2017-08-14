class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  def fan?
	  self.role == 'fan'
	end
	
	def moderator?
	  self.role == 'moderator'
	end 
end