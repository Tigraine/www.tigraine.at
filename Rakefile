require 'fileutils'

task :test do
	puts "Starting Copying Posts one by one"
	files = Dir.entries("posts")
	files.each() do |file| 
		if (file == "." or file == "..") then
		       next
		end
		cp_r("posts/#{file}", "_posts/#{file}")
		begin
			result = sh "jekyll"
		rescue
			puts "File #{file} is the problem"
			break
		end
	end

#	puts "result #{result}"
end

task :find do
	puts "Searching for wlwContent"
	files = Dir.entries("_posts")
	files.each() do |file|
		if (file != "." and file != "..") then
			openFile = File.open("_posts/#{file}", "r")
			content = ""
			openFile.each {|line| content += line}

			if (content =~ /wlWriterSmartContent/i)
				puts "#{file} still contains wlw Source"
			end
		end
	end
end
