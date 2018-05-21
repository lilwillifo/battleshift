class UserSetup
  def initialize(user)
    user.apikey = SecureRandom.hex
    user.save!
    UserActivatorMailer.welcome_email(user).deliver_now
  end
end
