require 'fileutils'

test = "hello world"
test =~ /world/

puts $&


files = Dir.entries("_posts")
files.each() do |file|
	if (file == "." or file == "..") then
		next
	end

	openFile = File.open("_posts\\#{file}", "r")
	content = ""
	openFile.each {|line| content += line}
	openFile.close

	if (content =~ /\<div.*wlWriterEditableSmartContent"\>.*class="(\S*)">\n((.*\n)*).*<.div>/) then
		content = content.gsub /\<div.*wlWriterEditableSmartContent"\>.*class="(\S*)">\n((.*\n)*?).*?<.div>/, '{% highlight \1 %}
\2
{% endhighlight %}'
	
		content = content.gsub /&#160;/, ' '

		content = content.gsub /{% highlight/, "\n{% highlight"

		newFile = File.open("test.html", "w")
		newFile.write(content)
		newFile.close

		exit
	end
end

puts "Number of files with code #{numberOfCodeFiles}"
puts "Number of files with matches #{num3}"
