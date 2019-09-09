module Link
  class Base < ApplicationRecord
    self.table_name = 'links'

    belongs_to :keyword
  end
end
