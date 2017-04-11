class CreateSpots < ActiveRecord::Migration[5.0]
  def change
    create_table :spots do |t|
      t.references :user, null: false
      t.float :lat, null: false
      t.float :lng, null: false
      t.boolean :precheckout, default: false
      t.boolean :checkout, default: false

      t.timestamps
    end
  end
end
