class FsFileController < ApplicationController

	def validate_admin_key
		puts "calling validate admin key"
	end
	def validate_client_key
		puts "calling validate client key"
	end

	def upload

		validate_admin_key

		newfile = FsFile.create(file_params)
		if newfile.add_file(file_params)
		  flash[:notice] = "Your file was uploaded!"
		else 
	      flash[:notice] = "There was an error."
	    end
		redirect_to :root
	end
	def download

		validate_client_key

		begin
		matches = FsFile.where(:file_id => file_params[:file_id], :site_id => file_params[:site_id])

		  @file = matches.first
  		  filename = @file.filepath.split('/')[-1]
		  send_file(
	        @file.filepath,
	        filename: filename,
	        type: @file.file_data_content_type
	   	  )
	   	rescue
	   		flash[:notice] = "That file does not exist"
	   		redirect_to :root
	   	end
	end
	
	private
  	  def file_params
	    params.require(:fs_file).permit(:file_id, :site_id, :file_data)
	  end
end
