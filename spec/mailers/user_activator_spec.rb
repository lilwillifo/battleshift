require "rails_helper"

RSpec.describe UserActivatorMailer, type: :mailer do
  context 'sends activation email' do
    let(:user) { User.create(id: 3000, name: 'Megan', email: 'kewlkid@hotmail.com', password: 'gIrLsRuLeBoYsDrOOl') }
    let(:mail) { UserActivatorMailer.welcome_email(user) }

    # before(:each) do
    #   allow_any_instance_of(User).to receive(:api_key).and_return("bb609b650e6022e0b5fbd1fae290b5e9")
    # end

    it 'loads the email' do
      expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it "renders the headers and body" do
      expect(mail.subject).to eq("Welcome to BattleShift, #{user.name}")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["app96560814@heroku.com"])

      text_body = File.read('spec/fixtures/user_activator_mailer/activate.txt')
      html_body = File.read('spec/fixtures/user_activator_mailer/activate.html')
      expect(mail.text_part.body.to_s.chomp).to match(text_body)
      expect(mail.html_part.body.to_s).to match(html_body)
    end
  end
end
