require 'rails_helper'

RSpec.describe Task, type: :model do
  before(:each) do 
    User.create(email:"Test@gmail.com", password:"123456", password_confirmation:"123456")
    User.first.categories.create(name:"Test")
    @Task = User.first.categories.first.tasks
  end
  context "Data Creation" do
    it "1. It should create a task" do
      expect(@Task.create(title:"Test", description:"Test", task_date_string:"2021-12-07")).to be_valid
    end
    it "2. It should not create a task without missing parameters" do
      expect(@Task.create(title:"Test", description:"Test")).to_not be_valid
    end
    it "3. It should create a task with and convert string to date" do
      expect(@Task.create(title:"Test", description:"Test", task_date_string:"2021-12-07")).to be_valid
      expect(Task.first.task_date) == Date.parse("2021-12-07")
    end
  end
end
