class CreateUserRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_roles do |t|
      t.integer :user_id
      t.string :role

      t.timestamps
    end
  end
end
