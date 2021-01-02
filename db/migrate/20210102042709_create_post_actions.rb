class CreatePostActions < ActiveRecord::Migration[6.1]
  def change
    create_table :post_actions do |t|
      t.integer :action_type
      t.integer :post_id

      t.timestamps
    end
  end
end
