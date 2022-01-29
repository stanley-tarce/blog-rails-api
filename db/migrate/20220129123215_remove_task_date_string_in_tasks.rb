class RemoveTaskDateStringInTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :task_date_string
  end
end
