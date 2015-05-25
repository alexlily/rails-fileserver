class ClientKeyToFsFiles < ActiveRecord::Migration
  def change
    add_column :fs_files, :client_key, :string
  end
end
