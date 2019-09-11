module KeywordResult
  include ActiveSupport::Concern

  def transform_result(relations)
    relations.each_with_object(HashWithIndifferentAccess.new) do |relation, agg|
      current_keyword_id = relation.id
      current_keyword_hash = agg[current_keyword_id] || {}
      agg[current_keyword_id] = current_keyword_hash.merge(
        term: relation.term,
        "#{relation.type}": relation.count,
        total_results: relation.total_results
      )
    end
  end
end
