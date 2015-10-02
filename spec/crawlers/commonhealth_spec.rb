require 'rails_helper'
require 'classes/crawler'
require 'classes/crawler/commonhealth'


describe "commonhealth_crawler" do

  it "crawel url" do
    index_url = "http://www.commonhealth.com.tw/medical/findHospital.action?&policlinic=0&page=2"
    c = Crawler::Commonhealth.new
    c.fetch index_url
    c.crawl_co_urls

    hospital = Hospital.first

    expect(hospital).not_to be nil
    expect(hospital.coUrl).not_to be nil
  end

end