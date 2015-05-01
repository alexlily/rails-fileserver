class WelcomeController < ApplicationController
	def index
		@fs_file ||= FsFile.new
	end
end
