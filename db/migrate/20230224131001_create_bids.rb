class CreateBids < ActiveRecord::Migration[6.1]
  def change
    create_table :bids do |t|
      t.references :user, null: false, foreign_key: true
      t.float :amount

      t.timestamps
    end
  end
end
