class RemoveSpotFromUsers < ActiveRecord::Migration[5.0]
  def up
    remove_reference :users, :spot, index: true
  end
end
