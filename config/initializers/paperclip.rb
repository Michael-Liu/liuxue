require 'digest/sha1'
# 扩展 Paperclip 加入hash目录参数 :hashed_path

# 建立 config/initializers/paperclip_extensions.rb
Paperclip.interpolates :hashed_path do |attachment, style|
  hash = Digest::SHA1.hexdigest(attachment.instance.id.to_s)
  # hash_path = ''
  # 3.times { hash_path += '' + hash.slice!(0..2) }
  hash[1..16]
end

Paperclip.interpolates :date do |attachment, style|
  attachment.instance.created_at.strftime("%Y/%m")
end
