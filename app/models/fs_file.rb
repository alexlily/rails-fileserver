class FsFile < ActiveRecord::Base
	has_attached_file :file_data
	validates_attachment_content_type :file_data, :content_type => ["application/pdf", "text/plain"]

	def add_file(upload)
		name = upload[:file_data].original_filename
		directory = ENV["RA_FILESERVER_DIRECTORY"] # set with environment variable? 
		if not directory
			return false
		end
		path = File.join(directory, name)
		self.filepath = path
		save!
    	File.open(path, "wb") { |f| f.write(upload[:file_data].read) }
	end
	def self.download(upload)

	end
end
