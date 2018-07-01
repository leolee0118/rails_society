class Club < ApplicationRecord
    has_many :articles
    has_many :events
    has_many :user_clubships
    has_many :users, through: :user_clubships
end
