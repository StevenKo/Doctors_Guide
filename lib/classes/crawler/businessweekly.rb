# encoding: utf-8
class Crawler::Businessweekly
  include Crawler
  
  def crawl_bw_doctors_url
    nodes = @page_html.css('.searchresults a')
    nodes.each do |node|
      link = node[:href]

      d = Doctor.find_or_initialize_by(bUrl: link)
      d.save
    end
  end

  def crawl_doctor_detail doctor
    lis = @page_html.css(".detailinfo li")
    div = lis[0].css("a").text

    hosp = ""
    lis.each do |li|
      strong = li.css("strong")
      if strong.text == "醫院名稱："
        hosp = li.css("a").text
      end
    end

    phone = ""
    lis.each do |li|
      strong = li.css("strong")
      if strong.text.match(/電.*話/)
        li.css("strong").remove
        phone = li.text.strip
      end
    end

    addr = ""
    lis.each do |li|
      strong = li.css("strong")
      if strong.text == "醫院地址："
        li.css("a,strong").remove
        addr = li.text.strip
      end
    end

    name = @page_html.css(".doct_name h1").text.gsub("醫師","").strip
    spes = @page_html.css("li#ContentPlaceHolder1_IDoctorHead1_professional li")
    exps = @page_html.css("li#ContentPlaceHolder1_IDoctorHead1_experience li")

    doctor.div = div
    doctor.hosp = hosp
    doctor.address = addr
    doctor.phone = phone
    doctor.name = name
    doctor.spe = spes.collect{|x| x.text}.join("、")
    doctor.exp = exps.collect{|x| x.text}.join("、")
    doctor.save
  end
end