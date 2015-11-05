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
      NhiWorker.perform_async(hosp.id)
    end
  end

  task :crawl_commonhealth_hospitals => :environment do
    (1..2).each do |page|
      CommonhealthHospWorker.perform_async(page)
    end
  end

  task :crawl_commonhealth_doctors => :environment do
    (1..2).each do |page|
      CommonhealthDocWorker.perform_async(page)
    end
  end

  task :crawl_businessweekly_doctors => :environment do
    (1..2).each do |page|
      BusinessweeklyDocWorker.perform_async(page)
    end
  end
end