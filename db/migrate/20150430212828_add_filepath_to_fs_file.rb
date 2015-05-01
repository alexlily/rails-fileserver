class AddFilepathToFsFile < ActiveRecord::Migration
  def change
  	add_column :fs_files, :filepath, :string
  	
  end
end
