class Article < ApplicationRecord
    belongs_to :user
    belongs_to :club, optional: true
end
