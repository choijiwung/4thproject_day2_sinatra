#block
# 1. {}
# 2. do ~ end
arr = ["john","mino","tak"]

arr.each do |name|
    puts name
    puts name +"입니다."
    puts "멋사직원" +name
end


phone_book = {
    "john" => "01011225",
    "mino" => "12445529",
    "tak" => "52151124"
}

phone_book.each {|key| puts key}
#|key| 임시변수

