#Re-time SRT files
def init_file(file_name)
  puts "Opening #{file_name}..."
  file = File.open(file_name, "r")
  timings = {}
  i=0
  file.each_with_index.map do | line, index |
    if line =~ /-->/
      (/^.*([0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}) --> .*([0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}).*/).match(line)
      timings[i.to_s.to_sym] = { start: $1, end: $2 }
      i = i+1
    end
  end
    puts "Found #{i-1} timing entries."
  timings
end

def ask_file
  puts "Enter your filename:"
  gets.chomp
end

def add_secs(val)

end

def sub_secs(val)

end

def ask_change

end

#Re-time SRT files
file_name = ask_file
timings = init_file(file_name)



