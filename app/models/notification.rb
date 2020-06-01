class Notification < ApplicationRecord
  default_scope->{order(created_at: :desc)}

  belongs_to :sender,   optional: true, foreign_key: "sender_id",   class_name: 'User'
  belongs_to :receiver, optional: true, foreign_key: "receiver_id", class_name: 'User'
  belongs_to :item,     optional: true 
  belongs_to :like,     optional: true 
  belongs_to :comment,  optional: true 
end
