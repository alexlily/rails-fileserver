class FsFileController < ApplicationController
	before_filter :authorize_user
	def authorize_user
		# check the client key here
	end
	def upload
		newfile = FsFile.create(file_params)
		if newfile.add_file(file_params)
		  flash[:notice] = "Your file was uploaded!"
		else 
	      flash[:notice] = "There was an error."
	    end
		redirect_to :root
	end
	def download
		matches = FsFile.where(:file_id => file_params[:file_id], :site_id => file_params[:site_id])

		if matches
		  @file = matches.first
		  puts @file.filepath
  		  filename = @file.filepath.split('/')[-1]
		  send_file(
	        @file.filepath,
	        filename: filename,
	        type: @file.file_data_content_type
	   	  )
	   	else
	   		flash[:notice] = "That file does not exist"
	   		redirect_to :root
	   	end
	end
	
	private
  	  def file_params
	    params.require(:fs_file).permit(:file_id, :site_id, :file_data)
	  end
end
