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

  def crawl_detail hosp
    lis = @page_html.css(".commonDrContentMain li")
    grade = ""
    lis.each do |li|
      span = li.css("span")
      if span.text == "評級 ："
        li.css("span").remove
        grade = li.text
      end
    end

    time = {}

    lis = @page_html.css("li#businessTimeLi ul > li")
    lis.each do |li|
      span_text = li.css("span").text
      if span_text == "平日看診"
        time_text = []
        li.css("li").each do |li|
          time_text.append(li.text)
        end
        time["weekday"] = time_text
      end

      if span_text == "夜間看診"
        time_text = []
        li.css("li").each do |li|
          time_text.append(li.text)
        end
        time["night"] = time_text
      end

      if span_text == "假日看診"
        time_text = []
        li.css("li").each do |li|
          time_text.append(li.text)
        end
        time["holiday"] = time_text
      end

      if li.attr('class') == "textLeft"
        time["special"] = li.text
      end
    end
    
    hosp.cHours = time
    hosp.grade = grade
    hosp.save
  end

end