class Post < ApplicationRecord
	belongs_to :user
	has_many :comments

	def author
	  User.find_by(id: self.user_id) if self.user_id
	end
	mount_uploaders :photos, PhotoUploader
	serialize :photos, JSON
end
