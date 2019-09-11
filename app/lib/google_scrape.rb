class GoogleScrape
  def initialize(keyword)
    @keyword = keyword
  end

  def scrape
    ::Link::Base.import(results.compact)
  end

  private

  def results
    all_results = search_google
    all_results.links.map do |link|
      if link_result?(link.href)
        ::Link::Result.new(link: scrub_url(link.href), text: link.text, keyword: @keyword)
      elsif link_ad?(link.href)
        ::Link::Ad.new(link: link.href, text: link.text, keyword: @keyword)
      end
    end
  end

  def search_google
    page = agent.get('http://www.google.com?hl=en')
    search_form = page.form_with(name: 'f')
    search_form.field_with(name: 'q').value = @keyword.term
    agent.submit(search_form)
  end

  def link_result?(url)
    url.match?(%r{\/url\?q=(.*)}) && !url.match?(%r{https:\/\/accounts.google.com})
  end

  def link_ad?(url)
    url.match?(%r{http:\/\/www.google.com\/aclk?})
  end

  def scrub_url(url)
    url.match(%r{\/url\?q=(.*)})[1]
  end

  def agent
    agent = Mechanize.new
    agent.user_agent = Mechanize::AGENT_ALIASES['Linux Mozilla']
    agent
  end
end
