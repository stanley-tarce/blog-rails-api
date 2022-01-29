
class Task < ApplicationRecord
  require 'date'
  scope :today, -> { where("task_date == #{Date.today}")}
  belongs_to :category
  validates :task_date, presence: true 
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 200 }, presence: true
  # Create a new task field task_date_string then create a method to convert it to a date 
end
