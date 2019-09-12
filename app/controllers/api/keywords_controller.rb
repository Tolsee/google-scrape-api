module Api
  class KeywordsController < ::ApplicationController
    include KeywordResult

    def index
      keyword_results = current_user.keyword_results

      return render json: { data: nil } if keyword_results.empty?
      render json: { data: transform_result(keyword_results) }
    end

    def batch
      error = validate_batch_params
      return render(json: { error: error }, status: :unprocessable_entity) if error

      # Import keyword and run GoogleScrapeBatchWorker
      ImportKeyword.new(batch_params, current_user).import

      render json: { data: transform_result(current_user.keyword_results) }
    end

    private

    def batch_params
      params.require(:keywords)
    end

    def validate_batch_params
      if !batch_params.is_a?(Array)
        'Keywords should be array'
      elsif batch_params.length > 100
        'Maximum 100 keywords are allowed'
      end
    end
  end
end
