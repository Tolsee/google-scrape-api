module Link
  class Base < ApplicationRecord
    self.table_name = 'links'

    belongs_to :keyword

    TYPE_MAPPER = {
      'Link::Ad': 'ad_link',
      'Link::Result': 'result_link'
    }.with_indifferent_access.freeze
  end
end
