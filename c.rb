#!/usr/bin/ruby

WIDTH=1000
HEIGHT=1000

def goodcand(scores, minx, maxx, miny, maxy)
  threshold = 9
  candx = minx
  candy = miny
#  p minx, maxx, miny, maxy
  for i in minx..maxx do 
    for j in miny..maxy do
      if scores[i][j] < threshold then
        candx = i
        candy = j
        threshold = scores[i][j]
      end
    end
  end
  #STDERR.print "take score:", threshold, " orderx:", candx, "ordery:",candy, "\n"
  if candx < 2 then
    candx = 2
  end
  if candx > WIDTH-1 then
    candx = WIDTH-1
  end
  if candy < 2 then
    candy = 2
  end
  if candy > WIDTH-1 then
    candy = WIDTH-1
  end

  return candx, candy
end

def printdigged(arr)
  STDERR.print "ERROR\n"
  for i in 0..(HEIGHT-1) do
    for j in 0..(WIDTH-1) do
      if arr[i][j] then
        STDERR.print "x"
      else
        STDERR.print "o"
      end
    end
    STDERR.print "\n"
  end
  STDERR.flush
end

def printscore(arr)
  for i in 0..(HEIGHT-1) do
    for j in 0..(WIDTH-1) do
        STDERR.print arr[i][j]
    end
    STDERR.print "\n"
  end

end

def solve()  
  minsquare = $stdin.readline.chomp.to_i
 
  digged = Array.new(HEIGHT).map{Array.new(WIDTH, false)}
  scores = Array.new(HEIGHT).map{Array.new(WIDTH, 0)}
  minx = HEIGHT/2
  maxx = HEIGHT/2
  miny = WIDTH/2
  maxy = WIDTH/2
  puts minx.to_s + " " + miny.to_s
  STDOUT.flush

  while true do
    digxs, digys = $stdin.readline.split
    digx = digxs.to_i
    digy = digys.to_i
    # STDERR.print digx,",", digy,"\n"
    if digx == 0 and digy == 0 then
      return
    end

    if digx == -1 and digy == -1 then
      #printdigged(digged)
      #printscore(scores)
      exit
    end

    if digged[digx][digy] == false then
      for i in -1..1 do
        for j in -1..1 do
          scores[digx + i][digy + j] = scores[digx + i][digy + j] + 1
          #          STDERR.print scores[digx + 1][digy + 1]
        end
      end
    end
    digged[digx][digy] = true
    
    if (digx > maxx) then
      maxx = digx
    end
    if (digx < minx) then
      minx = digx
    end
    if (digy > maxy) then
      maxy = digy
    end
    if (digy < miny) then
      miny = digy
    end

    
    curwidth = maxx - minx + 1
    curheight = maxy - miny + 1
    #STDERR.print "w",curwidth,",", curheight, "\n"
    if curwidth * curheight > minsquare then
      # STDERR.print "ww\n"
      newx, newy = goodcand(scores, minx+1, maxx-1, miny+1, maxy-1)
    else
      newx, newy = goodcand(scores, minx, maxx, miny, maxy)
    end
    puts newx.to_s + " " + newy.to_s
    STDOUT.flush
  end    
end

tcount = $stdin.readline.chomp.to_i
tcount.times do |i|
  solve()
end
