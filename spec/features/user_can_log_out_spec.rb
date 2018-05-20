require 'rails_helper'

describe 'As a registered user' do
  context "When I visit /" do
    let(:user) { create(:user, apikey: SecureRandom.hex) }
    it "I can log in and out" do
      visit "/"
      click_on "Log in"

      expect(current_path).to eq "/log_in"

      fill_in "user[email]", with: 'ilanarox@fake.com'
      fill_in "user[password]", with: 'vErYsEcUrE'
      fill_in "user[password_confirmation]", with: 'vErYsEcUrE'
      click_on "Submit"

      expect(current_path).to eq "/dashboard"
      expect(page).to have_content "Log out"
    end
  end
end
