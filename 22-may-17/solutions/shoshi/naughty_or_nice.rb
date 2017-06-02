input = File.open("input.txt", "r")
nice_strings = 0

input.readlines.each do |line|
  next if line.match(/ab|cd|pq|xy/)
  next if line.scan(/[aeoui]/).count < 3
  nice_strings+=1 if line.match(/([a-z])\1/)
end

puts "Nice strings: #{nice_strings}"
input.close
