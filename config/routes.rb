RubyRailsSample::Application.routes.draw do
  root 'welcome#index'

  post 'fs_file/upload', :to => 'fs_file#upload', :format => false, :as => :put_file
  post 'fs_file/get_download_link', :to => 'fs_file#get_download_link', :format => false, :as => :get_download_link
  get 'fs_file/download', :to => 'fs_file#download', :format => false, :as => :get_file
  match 'credentials/create_admin', :to => 'user#create_admin', :format => false, :as => :credentials_new_admin, :via => [:post, :get]
  match 'credentials/create_client', :to => 'user#create_client', :format => false, :as => :credentials_new_client, :via => [:post, :get]
   
end
