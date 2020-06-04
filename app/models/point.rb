class Point < ApplicationRecord
  belongs_to :user

  scope :user, ->(user_id) {find_by(user_id: user_id)}
  
  with_options presence: true do
    validates :user_id
    validates :point
  end
end
