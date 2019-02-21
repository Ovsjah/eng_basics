class AddSizeToFibs < ActiveRecord::Migration[5.2]
  def change
    add_column :fibs, :size, :integer
  end
end
