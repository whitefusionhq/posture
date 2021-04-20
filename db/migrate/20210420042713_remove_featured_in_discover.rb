class RemoveFeaturedInDiscover < ActiveRecord::Migration[6.1]
  def change
    remove_column :sources, :featured_in_discover, :boolean
  end
end
