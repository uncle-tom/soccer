class Comment < ApplicationRecord
	belongs_to :post

	def author_comment
	  User.find_by(id: self.user_id) if self.user_id
	end

	def children
	  Comment.where(['parent_id = ?', self.id])
	end
end
