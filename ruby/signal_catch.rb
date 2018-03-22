# Ctrl+CなどでSIGINTシグナルを送ると 'catch SIGINT' と出力してプログラムを終了する
finish = false

Signal.trap(:INT) do
  puts "catch SIGINT"
  finish = true
end

loop do
  break if finish
  puts "hello"
  sleep 1
end