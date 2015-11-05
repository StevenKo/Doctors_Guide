# encoding: utf-8
class Crawler::Nhi
  include Crawler
  
  def crawle_hospital_urls
    nodes = @page_html.css('[id*="lblHospName"] a')
    nodes.each do |node|
      h = Hospital.new
      h.nhiUrl = get_url(node[:href])
      h.save
    end
  end

  def crawl_detail hosp
    code = @page_html.css("#lblHospID").text
    name = @page_html.css("#lblHospName").text
    phone = @page_html.css("#lblTel").text
    address = @page_html.css("#lblAddress").text
    grade = @page_html.css("#lblSpecial").text
    services = @page_html.css("#lblService").text.split("、")
    divisions = @page_html.css("#lblFunc").text.split("、")

    hosp.code = code
    hosp.name = name
    hosp.phone = phone
    hosp.address = address
    hosp.grade = grade
    hosp.services = services
    hosp.divisions = divisions

    hosp.save
  end
end