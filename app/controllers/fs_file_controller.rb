class FsFileController < ApplicationController

	def validate_admin_key(key)
		if (key == nil)
			return false
		end
		admin = User.find_by_admin_key(key)
		if not admin
			return false
		end
		return true
	end
	
	def validate_client_key(key)
		if (key == nil)
			return false
		end
		user = User.find_by_client_key(key)
		if not user
			return false
		end
		return true
	end

	def errormessage
		flash[:notice] = "This operation is not allowed"
		redirect_to :root
	end

	def upload
		errormessage and return unless validate_admin_key(params[:admin_key])

		newfile = FsFile.create(file_params)
		if newfile.add_file(file_params)
		  flash[:notice] = "Your file was uploaded!"
		else 
	      flash[:notice] = "There was an error."
	    end
		redirect_to :root
	end
	def download
		errormessage and return unless validate_client_key(params[:client_key])
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
