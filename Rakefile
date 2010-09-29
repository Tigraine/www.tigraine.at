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
