class AddNewStringForUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :role, :string, default:'fan'
  	add_column :users, :city, :string
  	add_column :users, :avatar, :string
  	add_column :users, :name, :string, default: 'Фанат Милевского'
  end
end
