class Category < ApplicationRecord
  has_ancestry
  has_many :items

  scope :ancestries, ->(ancestry) {where(ancestry: ancestry)}
  scope :name_not, ->(name) {where.not(name: name).pluck(:name)}
end
