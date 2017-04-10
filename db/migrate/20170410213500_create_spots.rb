class CreateSpots < ActiveRecord::Migration[5.0]
  def change
    create_table :spots do |t|
      t.references :user_id
      t.string :location
      t.boolean :precheckout
      t.boolean :checkout

      t.timestamps
    end
  end
end
