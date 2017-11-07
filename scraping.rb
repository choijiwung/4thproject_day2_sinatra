require 'httparty'
require 'nokogiri'

url = "http://sports.news.naver.com/wfootball/news/read.nhn?oid=413&aid=0000057349"
response = HTTParty.get(url)
# puts response

text = Nokogiri::HTML(response.body)
soccer = text.css('#newsEndContents')
puts soccer.text
