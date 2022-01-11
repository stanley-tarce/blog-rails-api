class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks, id: :uuid do |t|
      t.string :title
      t.string :description
      t.string :task_date_string
      t.date :task_date
      t.belongs_to :category, null: false, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
