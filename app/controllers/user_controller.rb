class UserController < ApplicationController
  def create_admin
    u = AdminUser.create!
    render :json => {:admin_key => u.admin_key,:client_key => u.client_key}
  end
  def create_client
    u = ClientUser.create!
    render :json => {:client_key => u.client_key}
  end
end
