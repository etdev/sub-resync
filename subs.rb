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

def ask_change
  puts "Enter your change start time: "
  start = gets.chomp
  puts "Enter the time difference in seconds: "
  diff = gets.chomp
  if (diff[0] == '-')
    retime(start, diff, '-')
  else
    retime(start, diff, '+')
  end
end

def retime(start, diff, op)
  diff = diff.to_i.abs
  @timings.each do | id, val |
    old_start = val[:start]
    old_end = val[:end]
    if get_secs(old_start) > get_secs(start)
      if op == '+'
        new_start_secs = get_secs(old_start) + diff
        new_end_secs = get_secs(old_end) + diff
      elsif op == '-'
        new_start_secs = get_secs(old_start) - diff
        new_end_secs = get_secs(old_end) - diff
      end
      val[:start] = get_normalized(new_start_secs)
      val[:end] = get_normalized(new_end_secs)
    end
  end
end

def normalize(val)
  if !(/^([0-9]+):([0-9]+):([0-9]+),([0-9]+)$/).match(val)
    hours = $1.to_i
    mins = $2.to_i
    secs = $3.to_i
    milis = $4.to_i

    while secs > 60
      mins = mins+
      secs = secs-60
    end

    while mins > 60
      hours = hours+1
      mins = mins-60
    end
    return "#{hours}:#{mins}:#{secs}:#{milis}"
  else
    puts "ERROR: CAN'T NORMALIZE THAT TIMING"
  end
  return nil
end

def get_normalized(num_secs)
  hours = 0
  mins = 0
  secs = num_secs

  while secs > 60
    mins = mins+1
    secs = secs-60
  end

  while mins > 60
    hours = hours+1
    mins = mins-60
  end
  return "#{hours}:#{mins}:#{secs},000"
end

def get_secs(val)

  if (/^([0-9]+):([0-9]+):([0-9]+),([0-9]+)$/).match(val)
    hours = ($1.to_i)
    mins = ($2.to_i)
    secs = ($3.to_i)
    total = (hours.to_i)*3600 + (mins.to_i)*60 + (secs.to_i)
    return total.to_i
  else
    puts "ERROR: CAN'T GET SECS"
    return 0
  end
end

#Re-time SRT files
file_name = ask_file
@timings = init_file(file_name)
ask_change
puts @timings


