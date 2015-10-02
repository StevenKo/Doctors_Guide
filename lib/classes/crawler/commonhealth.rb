# encoding: utf-8
class Crawler::Commonhealth
  include Crawler

  def crawl_co_urls
    nodes = @page_html.css('.commonDrList a')
    nodes.each do |node|
      next if node[:href].include?("javascript")
      link = node[:href]
      name = node.css('img')[0][:alt]

      h = Hospital.find_or_initialize_by(name: name)
      h.coUrl = link
      h.save
    end
  end

end