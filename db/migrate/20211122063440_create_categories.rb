class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories, id: :uuid do |t|
      t.belongs_to :user, :null => false, type: :uuid, foreign_key: "user_id"
      t.string :name
      t.string :slug
      t.timestamps
    end
  end
end
