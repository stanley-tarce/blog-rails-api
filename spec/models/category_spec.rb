# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:each) do
    User.create(email: 'Test@gmail.com', password: '123456', password_confirmation: '123456')
    @Category = User.first.categories
  end
  context 'Uniqueness of the Data' do
  
    it '1. Should not be empty' do
      expect(@Category.create(name: nil).valid?).to eq(false)
    end

    it '2. Length should be minimum of 3' do
      expect(@Category.create(name: 'T').valid?).to eq(false)
    end

    it '3. Length should not exceed more than 25' do
      expect(@Category.create(name: 'Hellohellohellohelloh ellohellohellohelloheloo').valid?).to eq(false)
    end
  end

  context 'Slugify Method' do
    it '1. method would work' do
      expect(@Category.create(name: 'Test').slugify).to eq('test')
    end
    it '2. method would work on name with spaces' do
      expect(@Category.create(name: 'Stanley Test').slugify).to eq('stanley-test')
    end
  end
end
