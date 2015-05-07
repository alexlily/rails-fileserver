class ClientUser < User

  after_initialize :init

  validate :no_admin_key

  def no_admin_key
  	if not self.admin_key.nil?
  		errors.add :client_user, "cannot have an admin key"
  	end
  end

  def init
    self.client_key ||= SecureRandom.hex(20)
  end

end
