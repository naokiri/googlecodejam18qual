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

def swap (prog, i)
  prog[0,i] + prog[i,2].reverse + prog[i+2,prog.length]
end

def swapped (prog, depth)
  """
    depth time swapped program list
  """
  if depth == 0 then
    return Array[prog]
  end
  len = prog.length-1
  tmp = []
  depth.times do |d|
    len.times do |i|
      tmp = tmp + swapped(swap(prog, i), depth - 1)
    end
  end
  tmp
end

def solve(ccount, prog, shield)
  memo = {}
  maxdep = prog.length + 1
  maxdep.times do |i|
    test = swapped(prog, i)
    test.each do |hacked|
      # p atk(memo,hacked)
      if(atk(memo,hacked) <= shield) then
        # p memo
        puts "Case #" + ccount.to_s + ": " + i.to_s
        return
      end
    end
  end
  # p memo
  puts "Case #" + ccount.to_s + ": IMPOSSIBLE"
  
end

tcount = $stdin.readline.chomp.to_i
tcount.times do |i|
  memo = {}
  shield, prog = $stdin.readline.split
  shield = shield.to_i
  solve(i+1, prog, shield)
end

