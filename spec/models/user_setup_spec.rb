require 'spec_helper'

describe UserSetup, type: :model do
  describe 'instance methods' do
    it 'initialize creates API key and delivers email' do
      user = create(:user)
      UserSetup.new(user)

      expect(user.apikey.length).to eq(32)

    end
  end
end
