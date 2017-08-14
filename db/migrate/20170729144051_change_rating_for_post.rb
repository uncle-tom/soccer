class ChangeRatingForPost < ActiveRecord::Migration[5.1]
  def change
  	change_column :posts, :rating, :integer, default: 0
  end
end
