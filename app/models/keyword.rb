class Keyword < ApplicationRecord
  has_many :keyword_users, dependent: :destroy
  has_many :users, through: :keyword_users
  has_many :links, class_name: 'Link::Base', foreign_key: :keyword_id, dependent: :destroy
end
