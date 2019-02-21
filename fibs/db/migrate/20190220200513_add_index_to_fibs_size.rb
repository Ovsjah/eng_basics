class AddIndexToFibsSize < ActiveRecord::Migration[5.2]
  def change
    add_index :fibs, :size
  end
end
