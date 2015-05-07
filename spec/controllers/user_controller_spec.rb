require 'rails_helper'

RSpec.describe UserController, type: :controller do

  describe "expected UserController actions " do
    it "responds to create admin" do
      expect(UserController.new).to respond_to(:create_admin)
    end
    it "responds to create client" do
      expect(UserController.new).to respond_to(:create_client)
    end
  end

  describe "UserController create admin responses " do
    before(:each) do
      put :create_admin
      @result = JSON.parse(response.body)
    end
    it "returns success create_admin" do
      expect(response).to be_success 
    end
    it "returns an admin key" do
      expect(@result).to include('admin_key')
    end
    it "returns a client key" do
      expect(@result).to include('client_key')
    end
    it "returns a long enough admin key" do
      expect(@result['admin_key'].length).to be  >= 20
    end
    it "returns a long enough client key" do
      expect(@result['client_key'].length).to be  >= 20
    end
  end

  describe "UserController create client responses " do
    before(:each) do
      put :create_client
      @result = JSON.parse(response.body)
    end
    it "returns success create_admin" do
      expect(response).to be_success 
    end
    it "doesn't return an admin key" do
      expect(@result).to_not include('admin_key')
    end
    it "returns a client key" do
      expect(@result).to include('client_key')
    end
    it "returns a long enough client key" do
      expect(@result['client_key'].length).to be  >= 20
    end
  end

end
