class UserController < ApplicationController
  def create_admin
    u = AdminUser.create!
    render :json => {:admin_key => u.admin_key,:client_key => u.client_key}
    return u.admin_key
  end
  def create_client
    client_key = make_new_client(params[:admin_key])
    if not client_key
  		render :json => false
  		return
  	end
    render :json => {:client_key => client_key}
    return client_key
  end
end
