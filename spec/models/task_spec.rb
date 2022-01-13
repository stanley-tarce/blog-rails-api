# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  before(:each) do
    # User.create(email:"Test@gmail.com", password:"123456", password_confirmation:"123456")
    # User.first.categories.create(name:"Test")
    # @Task = User.first.categories.first.tasks
    @task = FactoryBot.create(:task)
  end
  context 'Data Creation' do
    it '1. It should create a task' do
      expect(@task.valid?).to eq(true)
    end

    it '2. It should have Task Date' do
      expect(@task.task_date.class).to eq(Date)
    end
  end
  context 'Invalid Attributes' do
    it '1. It should not create a task without a task date' do
      @task = FactoryBot.build(:task, task_date: nil)
      expect(@task.save).to eq(false)
    end
    it '2. It should not create a task without a title' do
      @task = FactoryBot.build(:task, title: nil)
      expect(@task.save).to eq(false)
    end
    it '3. It should not create a task without a description' do
      @task = FactoryBot.build(:task, description: nil)
      expect(@task.save).to eq(false)
    end
  end
end
