class AddNewStringForPosts < ActiveRecord::Migration[5.1]
  def change
  	add_column :posts, :code, :text
  end
end
