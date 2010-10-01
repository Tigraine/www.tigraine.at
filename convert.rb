require 'fileutils'

test = "hello world"
test =~ /world/

puts $&


files = Dir.entries("_posts")
files.each() do |file|
	if (file == "." or file == "..") then
		next
	end

	openFile = File.open("_posts\\#{file}", "w+")
	content = ""
	openFile.each {|line| content += line}
	openFile.close

	if content =~ /wlWriterEditableSmartContent/ then
		puts "#{file} contains code"
	end
end
