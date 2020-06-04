class Message < ApplicationRecord
  belongs_to :from, class_name: "User"
  belongs_to :room, class_name: "Item"
  
  scope :including, -> {includes(:from)}
  scope :asc,       -> {order('created_at ASC')}

  with_options presence: true do
    validates :message
    validates :from_id
    validates :to_id
    validates :room_id
  end
end
