require 'fileutils'

numberOfChangedFiles = 0
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
		content = content.gsub /\<div.*wlWriterEditableSmartContent"\>.*class="(\S*)">\n((.*\n)*?).*?<.div>/, '{% highlight \1 linenos %}
\2
{% endhighlight %}'
	
		content = content.gsub /&#160;/, ' '
		content = content.gsub /(?!^title:)&gt;/, '>'
		content = content.gsub /(?!^title:)&lt;/, '<'

		content = content.gsub /{% highlight/, "\n{% highlight"

		newFile = File.open("_posts\\#{file}", "w")
		newFile.write(content)
		newFile.close

		numberOfChangedFiles += 1
	end
end

puts "Number of changed files #{numberOfChangedFiles}"
