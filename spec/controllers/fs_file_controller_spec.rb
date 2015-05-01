require 'rails_helper'

RSpec.describe FsFileController, type: :controller do

  describe 'upload a file' do
  	it 'makes a new FsFile model' do
  	  expect {post :upload, "fs_file" => {"site_id" => "hi", "file_id" => "hello", "file_data" => Rack::Test::UploadedFile.new("hw0.pdf", "application/pdf")}
  	  }.to change{FsFile.all.length}.by(1)
  	end 
  end 
  describe 'download a file' do
  	it 'looks for a nonexistant FsFile model' do
  	  FsFile.should_receive(:where).and_return(nil)
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
