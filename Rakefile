require 'fileutils'

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

task :default do
	sh "Jekyll --pygments"
end

task :test do
	sh "Jekyll --pygments --server 3000 --auto"
end
