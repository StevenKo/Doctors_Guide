# encoding: utf-8
namespace :crawl do
  task :crawl_nhi_hospitals => :environment do
    @c = Crawler::Nhi.new
    @c.post_fetch("http://www.nhi.gov.tw/Query/query3_list.aspx",{SpecialCode: 1, PageNum: 10})
    @c.crawle_hospital_urls
  end

  task :crawl_nhi_hospitals_detail => :environment do
    hosps = Hospital.all
    hosps.each do |hosp|
      @c = Crawler::Nhi.new
      @c.fetch hosp.nhiUrl
      @c.crawl_detail hosp
    end
  end
end