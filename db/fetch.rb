# require 'net/http'
require 'rubygems'
require 'nokogiri'
require 'open-uri'

base_url = 'http://colleges.usnews.rankingsandreviews.com/best-colleges/rankings/national-universities/page+';

# def get_url(url)
  # Net::HTTP.get(URI(url))
# end

sql_str = "insert into schools(id, country_id, name, description, url, photo, address, expense, rank, gre, gpa, toefl, ielts, gmat, created_at, updated_at) values"
sql = []
# sql_2 = []

puts "start::::"
(1..28).each do |i|
  puts "page #{i} start::::"
  doc = Nokogiri::HTML(open(base_url + i.to_s))
  doc.css('div.school-description').each do |node|
    img_path = node.css('div.school-image img')[0]['src']
    img_name = img_path.split('/').last


    rank_node = node.css('span.rankings-score span')[0]
    rank = rank_node.nil? && 10000 || rank_node.text.split('#').last.gsub(/,/, '')
    school_node = node.css('a.school-name')[0]
    school_name = school_node.text
    school_url = school_node['href'].split('/').last
    school_id = school_url.split('-').last

    location_node = node.css('p.location')[0]
    location = location_node.text
    # description = node.css('div.school-blurb')[0].children[5].text
    description = node.css('p.school-links')[0].previous_sibling.previous_sibling.text.gsub(/[\n\s]{1,}/, ' ')

    expense = node.css('dl.stat dd')[0].text.split(' ').first.split('$').last

    puts "img_path=#{img_path}"
    puts "rank=#{rank}"
    puts "school_name=#{school_name}"
    puts "school_url=#{school_url}"
    puts "school_id=#{school_id}"
    puts "location=#{location}"
    puts "description=#{description}"
    puts "expense=#{expense}"


    sql << "('#{school_id}', 'meiguo', '#{school_name}', '#{description}', '#{school_url}', '#{img_name.downcase}', '#{location}', '#{expense}', '#{rank}', 0, 0, 0, 0, 0, now(), now())"

    # read image file
    unless img_path =~ /http:/
      img_path = "http://colleges.usnews.rankingsandreviews.com#{img_path}"
    end
    data = open(img_path){|f| f.read }
    open("images/#{img_name.downcase}", "wb"){|f| f.write(data)}
  end
end

# reg
=begin

puts "start:::::"
(1..28).each do |e|
  puts "page #{e} start::::"
  xml = get_url(base_url + e.to_s)
  ranks = xml.scan(/>\b*#(\d+)\b*</)
  # url_names = xml.scan(/href="(\/best-colleges\/[^"]+)">[^<]+<\/a>"/)
  url_names = xml.scan(/href="\/best\-colleges\/([a-zA-Z\-]+)([\d]+)">([^<]+)<\/a>/)
  imgs = xml.scan(/<img src="\/img\/(college\-photo_[\d]+\._130x0.[jpgJPG]{3})"/)
  location = xml.scan(/<p class="location">([^<]+)<\/p>/)
  text = xml.scan(/<p>([^<]*)<\/p>/)
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

=end

File.new("schools.sql", 'w').write(sql_str + sql.join(",\n"))
puts "end:::::"
