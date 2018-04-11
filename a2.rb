def atk (memo, prog)
  """ 
  memoized calc attack
  """
  if memo[prog] != nil then
    return memo[prog]
  end
  i = 1
  sum = 0
  prog.each_char do |c|
    if c == 'C' then
      i=i*2
    elsif c == 'S' then
      sum = sum + i
    end
  end
  memo[prog] = sum
  sum
end


def hack(prog)
  i = prog.rindex("CS")
  prog[0,i] + "SC" + prog[i+2,prog.length]
end

def solve(ccount, prog, shield)
  memo = {}
  res = 0
  if atk(memo, prog) <= shield then
      puts "Case #" + ccount.to_s + ": " + res.to_s
      return
  end

  
  while prog.rindex("CS") != nil do
    prog = hack(prog)
    res = res+1
    # p prog
    if atk(memo, prog) <= shield then
      puts "Case #" + ccount.to_s + ": " + res.to_s
      return
    end
  end
  puts "Case #" + ccount.to_s + ": IMPOSSIBLE"   
end

tcount = $stdin.readline.chomp.to_i
tcount.times do |i|
  memo = {}
  shield, prog = $stdin.readline.split
  shield = shield.to_i
  solve(i+1, prog, shield)
end
