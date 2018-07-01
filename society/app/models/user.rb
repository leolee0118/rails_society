class User < ApplicationRecord
    has_many :interests
    has_many :articles
    has_many :user_clubships
    has_many :clubs, through: :user_clubships
    has_many :user_eventships
    has_many :events, through: :user_eventships
end
