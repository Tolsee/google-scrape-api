class CreateKeywords < ActiveRecord::Migration[5.2]
  def change
    create_table :keywords do |t|
      t.string :term, null: false
      t.decimal :total_results

      t.timestamps
    end
    add_index :keywords, :term
  end
end
