require 'rails_helper'

RSpec.describe FsFileController, type: :controller do
  describe 'upload and download function without any authorization checking' do
    before (:each) do
      allow_any_instance_of(FsFileController).to receive(:validate_admin_key).and_return(true)
      allow_any_instance_of(FsFileController).to receive(:validate_client_key).and_return(true)
    end
    describe 'upload a file' do
  	  it 'makes a new FsFile model' do
  	    expect {post :upload, "fs_file" => {"site_id" => "hi", "file_id" => "hello", "file_data" => Rack::Test::UploadedFile.new("hw0.pdf", "application/pdf")}
  	    }.to change{FsFile.all.length}.by(1)
    	end 
      it 'calls the validation function' do
        expect(controller).to receive(:validate_admin_key)
        post :upload, "fs_file" => {"site_id" => "hi", "file_id" => "hello", "file_data" => Rack::Test::UploadedFile.new("hw0.pdf", "application/pdf")} 
      end
    end 
    describe 'download a file' do
      it 'calls the validation function' do
        expect(controller).to receive(:validate_client_key)
        post :download, "fs_file" => {"site_id" => "hi", "file_id" => "hello"}
      end
  	  it 'looks for a nonexistant FsFile model' do
        expect(FsFile).to receive(:where).and_return(nil)
  	    post :download, "fs_file"=>{"file_id"=>"hi", "site_id"=>"okay"}
  	  end
  	  it 'finds an existant file' do
  	    post :upload, "fs_file" => {"site_id" => "hi", "file_id" => "hello", "file_data" => Rack::Test::UploadedFile.new("hw0.pdf", "application/pdf")}
  	    file = FsFile.where(:site_id => "hi", :file_id => "hello").first

    	  post :download, "fs_file"=>{"file_id"=>"hello", "site_id"=>"hi"}
    	  expect(assigns(:file)).to eq(file)
    	end
    end
  end

  describe 'upload and download' do
    before(:each) do
      @admin = AdminUser.create!
    end
    it 'uploads a file with a key' do
      expect {post :upload, "admin_key" => @admin.admin_key, "fs_file" => {"site_id" => "hi", "file_id" => "hello", "file_data" => Rack::Test::UploadedFile.new("hw0.pdf", "application/pdf")}
        }.to change{FsFile.all.length}.by(1)
    end
    it 'does not upload a file without a key' do
      expect {post :upload, "fs_file" => {"site_id" => "hi", "file_id" => "hello", "file_data" => Rack::Test::UploadedFile.new("hw0.pdf", "application/pdf")}
        }.to change{FsFile.all.length}.by(0)
    end
    it 'uploads a file with a key' do
      post :upload, "fs_file" => {"site_id" => "hi", "file_id" => "hello", "file_data" => Rack::Test::UploadedFile.new("hw0.pdf", "application/pdf")}
      file = FsFile.where(:site_id => "hi", :file_id => "hello").first

      post :download, "fs_file"=>{"file_id"=>"hello", "site_id"=>"hi"}
      expect(assigns(:file)).to eq(file)
    end
    describe 'downlading a file' do
      before(:each) do
        post :upload, "client_key" => @admin.client_key, "fs_file" => {"site_id" => "hi", "file_id" => "hello", "file_data" => Rack::Test::UploadedFile.new("hw0.pdf", "application/pdf")}
        @file = FsFile.where(:site_id => "hi", :file_id => "hello").first
      end
      it 'downloads a file' do
        post :download, "client_key" => @admin.client_key, "fs_file"=>{"file_id"=>"hello", "site_id"=>"hi"}
        expect(assigns(:file)).to eq(@file)
      end
      it 'does not upload a file without a key' do
        post :download, "fs_file"=>{"file_id"=>"hello", "site_id"=>"hi"}
        expect(assigns(:file)).to_not be
      end
    end
    
  end

end
