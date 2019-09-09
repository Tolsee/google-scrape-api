class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.string :link, null: false
      t.string :text
      t.string :type
      t.references :keyword, index: true

      t.timestamps null: false
    end
  end
end
