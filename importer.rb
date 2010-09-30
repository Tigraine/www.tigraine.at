require 'rexml/document'
require 'date'
require 'htmlentities'
require 'fileutils'
include REXML

postsPath = "./_posts"
wpsource = "wordpress.xml"
puts "Migrating Wordpress posts from #{wpsource} to #{postsPath}"

if (!File.exists? wpsource) then
	puts "Cannot find file '#{wpsource}' please modify wp-source to match your Wordpress export file"
	exit 1
end

if (!File.directory? postsPath) then
	puts "Directory #{postsPath} does not exist. Creating it"
	FileUtils.mkdir(postsPath)
end

file = File.new(wpsource)
doc = REXML::Document.new file
counter = 0
skipped = 0
doc.elements.each("*/channel/item") do |element|
       postname =  element.elements["wp:post_name"].text
       title = element.elements["title"].text
       postid = element.elements["wp:post_id"].text
       guid = element.elements["guid"].text
       #Encoding of Post title
       coder = HTMLEntities.new
       title =  coder.encode(title, :named)
       postdate = element.elements["wp:post_date"].text
       if postdate == "0000-00-00 00:00:00" or element.elements["wp:post_type"].text != "post" then
	       next
       end
       counter += 1
       postdate = DateTime.parse(postdate)
       if postname.nil? or postdate.nil? then 
	       puts "Post #{element.elements["wp:post_id"].text} is incomplete"
	       skipped += 1
       end

       postdate = postdate.strftime("%Y-%m-%d")

       targetFile = File.open("./_posts/#{postdate}-#{postname}.html", "w:ASCII-8BIT")
       targetFile.puts("---")
       targetFile.puts("layout: post")
       targetFile.puts("title: \"#{title}\"")
       targetFile.puts("guid: #{guid}")
       targetFile.puts("postid: #{postid}")
       targetFile.puts("categories:")

       element.elements.each("category") do |category|
	      if category.attributes["domain"] == nil then
		      next
	      end
	      targetFile.puts("- #{category.attributes["nicename"]}")
       end

       targetFile.puts("---")
       targetFile.write(element.elements["content:encoded"].text)
       targetFile.close
end

puts "Finished migration of #{counter} posts. Skipped #{skipped} posts"
