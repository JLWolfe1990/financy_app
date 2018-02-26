class SignupService
  def self.perform(options)
    tenant_attrs = options[:tenant]
    user_attrs = options[:user]

    tenant = Tenant.find_by(name: tenant_attrs[:name])

    unless tenant
      tenant = Tenant.new(tenant_attrs)
      tenant.save!(validate: false)
    end

    Tenant.set_current_tenant tenant

    user = User.find_by(email: user_attrs[:email])
    unless user
      user = User.new
      user.email = user_attrs[:email]
      user.password = user_attrs[:password]
      user.password_confirmation = user_attrs[:password]
      user.save!
    end

    Member.create(user: user) unless user.member
  end
end
