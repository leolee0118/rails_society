class Event < ApplicationRecord
    has_many :user_eventships
    has_many :users, through: :user_eventships
    belongs_to :club
end
