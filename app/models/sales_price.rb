class SalesPrice < ApplicationRecord
  belongs_to :user
  with_options presence: true do
    validates :price
    validates :user_id
  end

  scope :user, ->(user_id) {find_by(user_id: user_id)}
end
