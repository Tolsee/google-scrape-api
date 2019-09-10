class ChangeUniquenessInKeywordsUser < ActiveRecord::Migration[5.2]
  def change
    add_index :keywords_users, [:keyword_id, :user_id], unique: true
  end
end
