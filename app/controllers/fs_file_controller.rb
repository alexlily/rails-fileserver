class FsFileController < ApplicationController


	def errormessage
		flash[:notice] = "This operation is not allowed"
		redirect_to :root
	end
	def invalidrequest
		flash[:notice] = "Invalid request"
		redirect_to :root
	end

	def get_download_link
		admin_key = params[:admin_key]
		errormessage and return unless validate_admin_key(admin_key)
		puts file_params
		matches = FsFile.where(:file_id => file_params[:file_id], :site_id => file_params[:site_id])
		file = matches.first
		client_key = make_new_client(admin_key)
		file.client_key = client_key
		file.save!
		render :json => {:link => "fs_file/download?file_id=#{file.file_id}&site_id=#{file.site_id}"}
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
		# errormessage and return unless validate_client_key(params[:client_key])
		puts "file id"
		puts params[:file_id]
		puts "site id"
		puts params[:site_id]
		begin
		matches = FsFile.where(:file_id => params[:file_id], :site_id => params[:site_id])

		# matches = FsFile.where(:file_id => file_params[:file_id], :site_id => file_params[:site_id])

		@file = matches.first
		invalidrequest and return unless validate_client_key(@file.client_key)

		filename = @file.filepath.split('/')[-1]
		send_file(
		  @file.filepath,
		  filename: filename,
		  type: @file.file_data_content_type
		)
		@file.client_key = nil
		@file.save!
	   	rescue
	   		puts "failleeedddd"
	   		# puts $!, $@
	   		flash[:notice] = "That file does not exist"
	   		redirect_to :root
	   	end
	end
	
	private
  	  def file_params
	    params.require(:fs_file).permit(:file_id, :site_id, :file_data)
	  end
end
