require 'securerandom'

class User < ActiveRecord::Base
  after_initialize :init

  def init
    self.admin_key  ||= SecureRandom.hex(20)
    self.client_key ||= SecureRandom.hex(20)
  end

end
