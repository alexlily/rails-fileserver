RubyRailsSample::Application.routes.draw do
  root 'welcome#index'

  post 'fs_file/upload', :to => 'fs_file#upload', :format => false, :as => :put_file
  post 'fs_file/download', :to => 'fs_file#download', :format => false, :as => :get_file
  match 'credentials/create', :to => 'user#create', :format => false, :as => :credentials_new, :via => [:post, :get]

end
