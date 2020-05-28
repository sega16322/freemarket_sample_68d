class Item < ApplicationRecord
  # belongs_to :buyer, class_name: User
  # belongs_to :saler, class_name: User
  has_many :images, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :category
  accepts_nested_attributes_for :images, allow_destroy: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_date
  belongs_to_active_hash :delivery_method
  belongs_to_active_hash :trading_status
  

  # 入力必須のバリデーション
  with_options presence: true do
    validates :name
    validates :explanation
    validates :category_id
    validates :status_id
    validates :category_id
    validates :delivery_charge_flag
    validates :prefecture_id
    validates :delivery_date_id
    validates :delivery_method_id
    validates :price
  end

  # 販売価格の数値範囲のバリデーション
  validates :price, numericality: {greater_than_or_equal_to: 300}
  validates :price, numericality: {less_than: 10000000}
  belongs_to :category

  has_many :notifications, dependent: :destroy
end
