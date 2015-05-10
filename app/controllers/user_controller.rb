class UserController < ApplicationController
  def create_admin
    u = AdminUser.create!
    session[:user] = u
    # redirect_to :root
    render :json => {:admin_key => u.admin_key,:client_key => u.client_key}
  end
  def create_client
    u = ClientUser.create!
    session[:user] = u
    # redirect_to :root
    render :json => {:client_key => u.client_key}
  end
end
