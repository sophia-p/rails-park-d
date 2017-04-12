class CreateDestinations < ActiveRecord::Migration[5.0]
  def change
    create_table :destinations do |t|
      t.references :user, null: false
      t.float :des_lat, null: false
      t.float :des_lng, null: false
      

      t.timestamps
    end
  end
end
