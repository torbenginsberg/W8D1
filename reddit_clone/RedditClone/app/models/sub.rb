class Sub < ApplicationRecord
    validates :title, presence: true, uniqueness: true 
    validates :description, presence: true 

    belongs_to :moderator,
        primary_key: :id, 
        foreign_key: :user_id,
        class_name: :User 
end
