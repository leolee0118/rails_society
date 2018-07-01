class AddColumns < ActiveRecord::Migration[5.2]
  def change
      add_column :users, :name, :string
      add_column :users, :student_id, :string
      add_column :users, :email, :string
      add_column :users, :description, :text
      add_column :articles, :title, :string
      add_column :articles, :content, :text
      add_column :articles, :is_public, :boolean
      add_column :articles, :user_id, :integer
      add_column :articles, :club_id, :integer
      add_column :interests, :field, :string
      add_column :interests, :description, :text
      add_column :interests, :rank, :integer
      add_column :interests, :user_id, :integer
      add_column :clubs, :name, :string
      add_column :clubs, :description, :text
      add_column :clubs, :manager_user_id, :integer
      add_column :events, :title, :string
      add_column :events, :description, :text
      add_column :events, :is_public, :boolean
      add_column :events, :creator_user_id, :integer
      add_column :events, :start_time, :timestamp
      add_column :events, :until_time, :timestamp
      add_column :events, :club_id, :integer
  end
end
