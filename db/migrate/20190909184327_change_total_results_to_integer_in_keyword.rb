class ChangeTotalResultsToIntegerInKeyword < ActiveRecord::Migration[5.2]
  def self.up
    change_column :keywords, :total_results, :integer
  end

  def self.down
    change_column :keywords, :total_results, :decimal
  end
end
