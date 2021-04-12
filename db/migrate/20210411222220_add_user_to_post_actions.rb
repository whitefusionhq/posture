class AddUserToPostActions < ActiveRecord::Migration[6.1]
  def change
    add_column :post_actions, :user_id, :integer
  end
end
