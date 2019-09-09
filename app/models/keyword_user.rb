class KeywordUser < ApplicationRecord
  self.table_name = 'keywords_users'

  belongs_to :user
  belongs_to :keyword
end
