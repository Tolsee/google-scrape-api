class GoogleScrapeBatchWorker
  include Sidekiq::Worker

  def perform(keyword_ids)
    keyword_ids.each_with_index { |id, index| GoogleScrapeWorker.perform_in(index.second.from_now, id) }
  end
end
