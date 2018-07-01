class AddIdColumns < ActiveRecord::Migration[5.2]
  def change
      add_column :user_clubships, :user_id, :integer
      add_column :user_clubships, :club_id, :integer
      add_column :user_eventships, :user_id, :integer
      add_column :user_eventships, :event_id, :integer
  end
end
