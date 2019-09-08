class CreateKeywordsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :keywords_users do |t|
      t.references :user, index: true, foreign_key: true
      t.references :keyword, index: true, foreign_key: true
    end
  end
end
