class AddColumn < ActiveRecord::Migration
  def change
    add_column :tanks, :user_id, :integer
  end
end
