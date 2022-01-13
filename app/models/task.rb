
class Task < ApplicationRecord
  require 'date'
  before_save :convert_date
  belongs_to :category
  before_create :convert_date
  validates :task_date, presence: true 
  validates :title, presence: true, length: { maximum: 50 }
  # validates :task_date_string, presence: true
  validates :description, length: { maximum: 200 }, presence: true
  def convert_date
    self.task_date = self.task_date.to_date if self.task_date
  end
  # Create a new task field task_date_string then create a method to convert it to a date 
end
