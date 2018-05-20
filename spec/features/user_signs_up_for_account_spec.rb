require 'rails_helper'

describe 'As a guest user' do
  context "When I visit / I can register for an account" do
    it "I can register for an account" do
      visit "/"
      click_on "Register"

      expect(current_path).to eq "/register"

      expect(ActionMailer::Base.deliveries.size).to eq(0)
      fill_in "user[email]", with: 'ilanarox@fake.com'
      fill_in "user[name]", with: 'Josh'
      fill_in "user[password]", with: 'vErYsEcUrE'
      fill_in "user[password_confirmation]", with: 'vErYsEcUrE'
      click_on "Submit"

      expect(current_path).to eq "/dashboard"
      user = User.last
      expect(user.name).to eq('Josh')
      expect(user.email).to eq('ilanarox@fake.com')
      expect(ActionMailer::Base.deliveries.size).to (1)
      expect(page).to have_content "Logged in as Josh"
      expect(page).to have_content "This account has not yet been activated. Please check your email."
    end
  end
end
