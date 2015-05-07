require 'rails_helper'

RSpec.describe User, type: :model do

  describe "AdminUser creation" do
    it "should generate a admin and client key" do
      u = AdminUser.create
      expect(u.admin_key.length).to be >= 10
      expect(u.admin_key).to be_an_instance_of(String)

      expect(u.client_key.length).to be >= 10
      expect(u.client_key).to be_an_instance_of(String)
    end
  end
  describe "ClientUser creation" do
    it "should generate a admin and client key" do
      u = ClientUser.create()

      expect(u.client_key.length).to be >= 10
      expect(u.client_key).to be_an_instance_of(String)
    end
  end

end
