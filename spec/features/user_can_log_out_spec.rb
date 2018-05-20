require 'rails_helper'

describe 'As a registered user' do
  context "When I visit /" do
    it "I can log in and out" do
      user = create(:user, apikey: SecureRandom.hex)
      visit "/"
      click_on "Log in"

      expect(current_path).to eq "/login"

      fill_in "email", with: 'fake@example.com'
      fill_in "password", with: 'kween'

      click_on "Login"

      expect(current_path).to eq "/dashboard"
      expect(page).to have_content "Log out"

      click_on "Log out"

      expect(current_path).to eq "/"
      expect(page).to have_content "Log in"
    end
  end
end
