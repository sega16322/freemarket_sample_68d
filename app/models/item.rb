class Item < ApplicationRecord
  # belongs_to :buyer, class_name: User
  # belongs_to :saler, class_name: User
  has_many :images, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :messages, class_name: "Message" ,foreign_key: "room_id", dependent: :destroy
  belongs_to :category
  accepts_nested_attributes_for :images, allow_destroy: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_date
  belongs_to_active_hash :delivery_method
  belongs_to_active_hash :trading_status

  scope :desc,                 -> {order('created_at DESC')}
  scope :including,            -> {includes(:images)}
  scope :trading_not,          -> {where.not(trading_status_id: 4..5)}
  scope :category,             -> (category_id)       {where(category_id: category_id)}
  scope :draft,                -> (saler_id)          {including.where(saler_id: saler_id).where(trading_status_id: 4)}
  scope :exhibition,           -> (saler_id)          {including.where(saler_id: saler_id).where(buyer_id: nil).trading_not}
  scope :exhibition_trading,   -> (saler_id)          {including.where(saler_id: saler_id).where.not(buyer_id: nil).trading_not}
  scope :exhibition_completed, -> (saler_id)          {including.where(saler_id: saler_id).where(trading_status_id: 5)}
  scope :bought,               -> (buyer_id)          {including.where(buyer_id: buyer_id).trading_not}
  scope :bought_completed,     -> (buyer_id)          {including.where(buyer_id: buyer_id).where(trading_status_id: 5)}
  
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

  
  #通知機能
  has_many :notifications, dependent: :destroy

  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      item_id: id,
      receiver_id: user_id,
      action: "like"
    )
    notification.save if notification.valid?
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    commenter_ids = Comment.select(:user_id).where(item_id: id).where.not(user_id: current_user.id).distinct
    commenter_ids.each do |commenter|
      save_notification_comment!(current_user, comment_id, commenter['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if commenter_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      item_id: id,
      comment_id: comment_id,
      receiver_id: receiver_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.sender_id == notification.receiver_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
