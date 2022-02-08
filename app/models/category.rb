class Category < ApplicationRecord
  before_create :slugify
  belongs_to :user
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }
  def slugify
    self.slug = name.parameterize
  end
end