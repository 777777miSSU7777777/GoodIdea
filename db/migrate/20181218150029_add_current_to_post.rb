class AddCurrentToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :current, :integer
  end
end
