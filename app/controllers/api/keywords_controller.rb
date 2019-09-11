module Api
  class KeywordsController < ::ApplicationController
    include KeywordResult

    def index
      keyword_results = current_user.keyword_results

      return render json: { data: nil } if keyword_results.empty?
      render json: { data: transform_result(keyword_results) }
    end

    def batch
      terms = batch_params
      unless terms.is_a?(Array)
        return render(json: { error: 'Keywords should be array' }, status: :unprocessable_entity)
      end
      if terms.length > 100
        return render(json: { error: 'Maximum 100 keywords are allowed' }, status: :unprocessable_entity)
      end

      import_keywords(terms)
      render json: { data: transform_result(current_user.keyword_results) }
    end

    private

    def batch_params
      params.require(:keywords)
    end

    def import_keywords(terms)
      new_terms = new_terms(terms)
      keyword_objects = new_terms.map { |term| Keyword.new(term: term) }

      keywords = Keyword.import keyword_objects

      keywords_users_objects = keywords.ids.map do |keyword_id|
        KeywordUser.new(keyword_id: keyword_id, user_id: current_user.id)
      end

      KeywordUser.import keywords_users_objects

      GoogleScrapeBatchWorker.perform_async(keywords.ids)
    end

    def new_terms(terms)
      keywords_present = Keyword.where(term: terms)
      terms.select do |term|
        keyword_present = keywords_present.find { |keyword| term == keyword.term }
        begin
          current_user.keywords << keyword_present if keyword_present.present?
        rescue Exception => e # rubocop:disable Lint/RescueException
          raise e unless e.message.include? 'PG::UniqueViolation'
        end
        keyword_present.nil?
      end
    end
  end
end
