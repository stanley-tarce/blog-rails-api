# frozen_string_literal: true

require 'rails_helper'
RSpec.describe User, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
  end
  context 'Valid Attributes' do
    it '1. It is valid with valid attributes' do
      expect(@user.valid?).to eq(true)
    end
    it '2. It should have an email' do
      !expect(@user.email).nil?
    end
  end
  context 'Invalid Attributes' do
    it '1. It is not valid without a email' do
      expect(User.create(email: '', password: '1234567', password_confirmation: '1234567').valid?).to eq(false)
    end
    it '2. It is not valid without a password' do
      expect(User.create(email: 'test@gmail.com', password: nil, password_confirmation: nil).valid?).to eq(false)
    end
  end
end
