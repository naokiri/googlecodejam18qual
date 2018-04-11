def solve(casenum, len, nums)
  odds = []
  evens = []
  len.times do |i|
    if i%2 == 0 then
      evens << nums[i].to_i
    else
      odds << nums[i].to_i
    end      
  end  
  odds.sort!
  evens.sort!
#  p evens
#  p odds

  (len-1).times do |i|
    if i%2==0 then
      if evens[i/2] > odds[i/2] then
        puts "Case #" + casenum.to_s + ": " + i.to_s
        return 
      end
    else
      if odds[(i-1)/2] > evens[(i+1)/2] then
        puts "Case #" + casenum.to_s + ": " + i.to_s
        return
      end
    end
  end
  puts "Case #" + casenum.to_s + ": OK"
end
tcount = $stdin.readline.chomp.to_i
tcount.times do |i|
  len = $stdin.readline.to_i 
  nums = $stdin.readline.split
  solve(i+1, len, nums)
end
