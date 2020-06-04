# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, unique: true|
|email|string|null: false, unique: true|
|password|string|null: false, unique: true|
|password_confirm|string|null, false|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birthday|date|null: false|

### Association
- has_many :saling_items, -> { where(buyer_id is NULL) }, foreign_key: saler_id,     class_name: item
- has_many :sold_items, -> { where(buyer_id is not NULL) }, foreign_key: saler_id, class_name: item
- has_many :buyed_items, foreign_key: buyer_id, class_name: Item
- has_many :likes
- has_many :from_messages, class_name: "Message", foreign_key: "from_id"
- has_many :comments
- has_one  :address
- has_one  :card
- has_one  :account
- has_one  :point
- has_one  :sales_price

## accountsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true, null: false|
|icon_image|string||
|background_image|string||
|introduction|text||


### Association
- belongs_to :user

##  addressテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|postal_code|string|null: false|
|prefectures|integer|null: false|
|municipality|string|null: false|
|address|string|null: false|
|building|string||
|phone_number|string||

### Association
- belongs_to :user

## itemsテーブル

|Column|Type|Options|
|------|----|-------|
|buyer_id|references|foreign_key: true|
|saler_id|references|foreign_key: true, null: false|
|category_id|references|null: false, foreign_key: true|
|name|string|null: false|
|explanation|text|null, false|
|status|string|null: false|
|delivery_charge_flag|string|null: false|
|prefectures|integer|null: false|
|delivery_data|string|null: false|
|price|integer|null: false|
|delivery_method|string|null: false|

### Association
- belongs_to :buyer, class_name: User
- belongs_to :saler, class_name: User
- belongs_to :category
- belongs_to :brand
- has_many   :likes
- has_many   :comment
- has_many   :images
- has_many   :messages, class_name: "Message", foreign_key: "room_id"

## imagesテーブル

|Column|Type|Options|
|------|----|-------|
|item_id|references|null: false, foreign_key: true|
|image|string|null: false|

### Association

- belongs_to  :item

## categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|path|string||
|name|string|null: false|

### Association

- has_many :items
- has_ancestry

## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|
|text|text|null: false|

### Association

- belongs_to :user
- belongs_to :item

## likesテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|

### Association

- belongs_to :user
- belongs_to :item

## cardsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|payjp_id_id|string|null: false|

### Association

- belongs_to :user

## messagesテーブル

|Column|Type|Options|
|------|----|-------|
|from|references|null: false, foreign_key: {to_table: users}|
|to|references|null: false, foreign_key: {to_table: users}|
|room|references|null: false, foreign_key: {to_table: items}|
|message|text|null: false|

### Association

- belongs_to :from, class_name: "User"
- belongs_to :room, class_name: "Item"

## sales_pricesテーブル

|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|price|integer|null: false|

### Association

- belongs_to :user

## pointsテーブル

|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|point|integer|null: false|

### Association

- belongs_to :user