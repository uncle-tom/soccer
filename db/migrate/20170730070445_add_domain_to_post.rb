class AddDomainToPost < ActiveRecord::Migration[5.1]
  def change
  	add_column :posts, :domain, :string, default: 'messiwho'
  end
end
