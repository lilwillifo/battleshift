require "rails_helper"

RSpec.describe UserActivatorMailer, type: :mailer do
  it "sends an email" do
    # Create the email and store it for further assertions
    user = User.create(name: 'Megan', email: 'kewlkid@hotmail.com', password: 'gIrLsRuLeBoYsDrOOl', apikey: ENV['USER_KEY'])
    email = UserActivatorMailer.welcome_email(user)
    # Send the email, then test that it got queued
    email.deliver_now

    expect(ActionMailer::Base.deliveries.last).to eq(email)

    # Test the body of the sent email contains what we expect it to

    # link = email.html_part.body.raw_source.match(/href="(?<url>.+?)">/)[:url]


    expect(email.from).to eq(["app96560814@heroku.com"])
    expect(email.to).to eq(['kewlkid@hotmail.com'])
    expect(email.subject).to eq('Welcome to BattleShift, Megan')
    expect(email.html_part.body.to_s).to have_content("Visit here to activate your account.")
    expect(email.html_part.body.to_s).to have_content("Here's your api key:")
    key = email.html_part.body.raw_source.match(/key: (?<key>.+?)\n/)[:key]
    expect(key.length).to eq(32)
    expect(email.html_part.body.to_s).to include(key)

    # assert_equal read_fixture('invite').join, email.body.to_s
  end
end
