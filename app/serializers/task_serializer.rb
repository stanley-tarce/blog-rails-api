class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :category_id, :task_date
end
