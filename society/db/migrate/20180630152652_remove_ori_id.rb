class RemoveOriId < ActiveRecord::Migration[5.2]
  def change
      remove_column :articles, :user_id
      remove_column :articles, :club_id
  end
end
