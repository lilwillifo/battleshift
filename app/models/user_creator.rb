class UserSetup
  def initialize(user)
    user.apikey = SecureRandom.hex
    UserActivatorMailer.welcome_email(user).deliver_now
  end
end
