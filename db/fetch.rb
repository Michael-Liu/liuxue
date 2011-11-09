require 'net/http'
require 'open-uri'

base_url = 'http://colleges.usnews.rankingsandreviews.com/best-colleges/rankings/national-universities/page+';

def get_url(url)
  Net::HTTP.get(URI(url))
end

sql_str = "insert into schools(id, country_id, name, description, url, photo, address, expense, rank, gre, gpa, toefl, ielts, gmat, created_at, updated_at) values"
sql = []
# sql_2 = []

puts "start:::::"
(2..28).each do |e|
  puts "page #{e} start::::"
  xml = get_url(base_url + e.to_s)
  ranks = xml.scan(/>\b*#(\d+)\b*</)
  # url_names = xml.scan(/href="(\/best-colleges\/[^"]+)">[^<]+<\/a>"/)
  url_names = xml.scan(/href="\/best\-colleges\/([a-zA-Z\-]+)([\d]+)">([^<]+)<\/a>/)
  imgs = xml.scan(/<img src="\/img\/(college\-photo_[\d]+\._130x0.[jpgJPG]{3})"/)
  location = xml.scan(/<p class="location">([\w,\s]+)<\/p>/)
  text = xml.scan(/<p>([^<]{100,})<\/p>/)
  fee = xml.scan(/<dd>\$([\d,]+)\s*[^<]*<\/dd>/)

  # puts "ranks::#{ranks}  "
  # puts "url_names::#{url_names}  "
  # puts "imgs::#{imgs}  "
  # puts "location::#{location}  "
  # puts "fee::#{fee}  "
  # puts "description::#{text}  "


  ranks.each_index do |index|
    puts "index=#{index}"
    puts "id=#{url_names[index][1]}"
    puts "name=#{url_names[index][2]}"
    puts "preffix=#{url_names[index][0]}"
    puts "description=#{text[index + 1][0]}"
    puts "imgpath=#{imgs[index][0]}"
    puts "locationss=#{location}"
    puts "locations=#{location[index]}"
    puts "location=#{location[index][0]}"
    puts "fee=#{fee[index][0]}"
    puts "rank=#{ranks[index][0]}"

    sql << "('#{url_names[index][1]}', 'meiguo', '#{url_names[index][2]}', '#{text[index + 1][0]}', '#{url_names[index][0]}#{url_names[index][1]}', '#{imgs[index][0].downcase}', '#{location[index][0]}', '#{fee[index][0]}', '#{ranks[index][0]}', 0, 0, 0, 0, 0, now(), now())"

    # read image file
    data = open("http://colleges.usnews.rankingsandreviews.com/img/#{imgs[index][0]}"){|f| f.read }
    open("images/#{imgs[index][0].downcase}", "wb"){|f| f.write(data)}
  end

  puts "page #{e} end::::"

  # sql << sql_2.join(',\n')
end

File.new("schools.sql", 'w').write(sql_str + sql.join(",\n"))
puts "end:::::"
