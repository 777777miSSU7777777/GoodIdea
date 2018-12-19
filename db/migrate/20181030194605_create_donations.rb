class CreateDonations < ActiveRecord::Migration[5.2]
  def change
    create_table :donations do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.text :msg

      t.timestamps
    end
  end
end
