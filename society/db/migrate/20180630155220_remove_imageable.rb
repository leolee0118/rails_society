class RemoveImageable < ActiveRecord::Migration[5.2]
  def change
      add_column :articles, :user_id, :integer
      add_column :articles, :club_id, :integer
      remove_column :articles, :imageable_id
      remove_column :articles, :imageable_type
  end
end
