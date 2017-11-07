require 'sinatra'
require 'nokogiri'
require 'httparty'
require 'uri'
require 'date'

get '/' do
    send_file 'index.html'
end

get '/welcome/:name' do
    "Welcome ! #{params[:name]}"
end

get '/lunch' do
    lunch =["20층","순남씨래기","오발탄","시골집"]
    @menu = lunch.sample
    # send_file 'lunch_html' #html은 마크업 언어 동적인 변환 할 수 없다. => 동적으로 할 수 있게 심어줘야 하는데 ERB(Embeded ruby)
    # "오늘 점심 메뉴는 #{menu}입니다."
  
    @photos ={
        "20층"=>'https://scontent-ort2-2.cdninstagram.com/t51.2885-15/s640x640/sh0.08/e35/18096427_637002683162292_8103999483869659136_n.jpg',
        "순남씨래기"=>'http://pds.joins.com/news/component/htmlphoto_mmdata/201507/10/htm_201507106658a010a012.jpg',
        "오발탄"=>'http://cfile22.uf.tistory.com/image/203172484EC7628126034B',
        "시골집"=> 'https://s-media-cache-ak0.pinimg.com/originals/92/7d/37/927d37e9b9d651f53f6c21b7ccad5fa5.jpg'
    }
    
   # @photos=photos[@menu]
    # 더 깔끔하게 할 수 있다. if문도 한번써봐(내생각)
    erb:lunch
end

get '/lol' do
    erb :lol
end

get '/search' do
    url = "http://www.op.gg/summoner/userName="
    @id = params[:userName]
    keyword = URI.encode(@id)
    res = HTTParty.get(url + keyword)
    text = Nokogiri::HTML(res.body)
    @win = text.css('#SummonerLayoutContent > div.tabItem.Content.SummonerLayoutContent.summonerLayout-summary > div.SideContent > div.TierBox.Box > div.SummonerRatingMedium > div.TierRankInfo > div.TierInfo > span.WinLose > span.wins')
    @lose = text.css('#SummonerLayoutContent > div.tabItem.Content.SummonerLayoutContent.summonerLayout-summary > div.SideContent > div.TierBox.Box > div.SummonerRatingMedium > div.TierRankInfo > div.TierInfo > span.WinLose > span.losses')
    # File.open("log.txt" , 'a+') do |f|
    #     f.write("#{@id}, #{@win.text}, #{@lose.text}," + Time.now.to_s + "\n")
    CSV.open('log.csv', 'a+') do |csv|
        csv << [@id,@win.text,@lose.text,Time.now.to_s]
    end
     erb :search
end

get '/log' do
    @log = []
    @rownum = 0
    CSV.foreach('log.csv') do |row|
        @log << row
        @rownum += 1
    end
    erb :log
end

get '/lotto' do
    @lotto = (1..45).to_a.sample(6)
    " 로또 번호 추천 : #{@lotto}"
    erb :lotto
end

get '/cube/:num' do
    input = params[:num].to_i
    result = input **3
    "The result is #{result}"
end



   #params[:num]에 사용자로 부터 넘어온 값이 저장되고 
   #1. params[:num]에있는 값을 세제곱한다
   # - params[:num]에 있는 값을 어딘가에 저장한다.
   # - 해당값을 세제곱한다.
   # - 그걸 어딘가에 저장한다.
   # 2.그걸 보여준다.
