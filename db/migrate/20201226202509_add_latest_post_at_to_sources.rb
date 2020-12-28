class AddLatestPostAtToSources < ActiveRecord::Migration[6.1]
  def change
    add_column :sources, :latest_post_at, :datetime
  end
end
