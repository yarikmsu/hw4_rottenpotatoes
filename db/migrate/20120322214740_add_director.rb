class AddDirector < ActiveRecord::Migration
  def up
    add_column :movies, :director, :boolean
  end

  def down
    remove_column :movies, :director 
  end
end
