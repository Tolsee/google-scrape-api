class GoogleScrapeWorker
  include Sidekiq::Worker

  def perform(keyword_id)
    keyword = Keyword.find_by(id: keyword_id)
    return if keyword.nil?

    GoogleScrape.new(keyword).scrape
  end
end
