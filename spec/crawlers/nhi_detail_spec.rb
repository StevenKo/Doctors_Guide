require 'spec_helper'
require 'classes/crawler'
require 'classes/crawler/nhi'

describe "nhi_crawler" do

  before(:all){ 
    @c = Crawler::Nhi.new
    @c.fetch "http://www.nhi.gov.tw/Query/Query3_Detail.aspx?HospID=1101150011"
  }


  it "id" do
    id = @c.page_html.css("#lblHospID").text
    expect(id).to eq("1101150011")
  end

  it "name" do
    name = @c.page_html.css("#lblHospName").text
    expect(name).to eq("新光醫療財團法人新光吳火獅紀念醫院")
  end


end