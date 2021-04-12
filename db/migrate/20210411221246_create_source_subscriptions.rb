class CreateSourceSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :source_subscriptions do |t|
      t.integer :user_id
      t.integer :source_id

      t.timestamps
    end
  end
end
