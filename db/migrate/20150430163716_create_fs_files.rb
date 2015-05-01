class CreateFsFiles < ActiveRecord::Migration
  def change
    create_table :fs_files do |t|
      t.string :file_id
      t.string :site_id
      t.attachment :file_data
      t.timestamps
    end
  end
end
