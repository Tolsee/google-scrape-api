class ImportKeyword
  def initialize(keywords, user)
    @keywords = keywords.uniq
    @user = user
  end

  def import
    keyword_objects = new_terms.map { |term| Keyword.new(term: term) }

    keywords = Keyword.import keyword_objects

    keywords_users_objects = keywords.ids.map do |keyword_id|
      KeywordUser.new(keyword_id: keyword_id, user_id: @user.id)
    end

    KeywordUser.import keywords_users_objects

    GoogleScrapeBatchWorker.perform_async(keywords.ids)
  end

  def new_terms
    keywords_present = Keyword.where(term: @keywords)
    @keywords.select do |term|
      keyword_present = keywords_present.find { |keyword| term == keyword.term }
      begin
        @user.keywords << keyword_present if keyword_present.present?
      rescue Exception => e # rubocop:disable Lint/RescueException
        raise e unless e.message.include? 'PG::UniqueViolation'
      end
      keyword_present.nil?
    end
  end
end
