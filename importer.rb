require 'rexml/document'
require 'date'
include REXML

file = File.new("wordpress.2010-09-28.xml")
doc = REXML::Document.new file
counter = 0
doc.elements.each("*/channel/item") do |element|
       postname =  element.elements["wp:post_name"].text
       #puts postname
       postdate = element.elements["wp:post_date"].text
       if postdate == "0000-00-00 00:00:00" then
	       next
       end
       postdate = DateTime.parse(postdate)
       #puts postdate
       if postname.nil? or postdate.nil? then 
	       puts "Post #{element.elements["wp:post_id"].text} is incomplete"
       end

       postdate = postdate.strftime("%Y-%m-%d")

       targetFile = File.open("./posts/#{postdate}-#{postname}.html", "w")
       targetFile.write(element.elements["content:encoded"].text)
       targetFile.close
end
