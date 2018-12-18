class AddGoalToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :goal, :integer
  end
end
