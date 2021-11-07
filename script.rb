data = Hash.new
path = File.open("config.txt").read.split('\\').join('/')
files = Dir.glob("#{path}/**/*").reject{|f| File.directory?(f)} 
files.each do |file|
    filename = File.basename(file)
    content = File.open(file).read
    
    if data.has_key?(content) 
        unless data[content][0].include?(filename)
            data[content] = [data[content][0] << filename, data[content][1] += 1]
        end
    else
        data[content] = [[]]
        data[content] = [data[content][0] << filename, 1]
    end    
end

result = data.sort{|a,b| a[1][1]<=>b[1][1]}.last
if result
    puts "#{result[0]} #{result[1][1]}" 
end