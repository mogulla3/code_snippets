retry_count = 0

begin
  1 / 0
rescue ZeroDivisionError
  puts "ZeroDivisionError is occurred. retry up to 3 times. retry_count=#{retry_count}"

  if retry_count < 3
    retry_count += 1
    sleep 1
    retry
  else
    puts "ERROR: retried 3 times but all failed. exit."
  end
end
