#!/usr/bin/env ruby

require 'fileutils'

intra = []
inter = []
regex = /_1_1.bmp/
results_file = File.open("results.txt", 'r')

results_file.each_line do |line|
  parts = line.split('|')
  left = parts[0]
  right = parts[1]
  dist = parts[2].chomp
  next if left >= right
  
  left_person = left.split('_').first
  right_person = right.split('_').first
  if left_person == right_person
    intra << dist.to_f
  else
    next unless left.match(regex) and right.match(regex)
#    print left, " | ", right, "\n"
    inter << dist.to_f
  end
end

print intra.length, " distances in intra\n"
print inter.length, " distances in inter\n"
#p intra.sort
File.open("intra_dists.txt", 'w') { |f| f.puts intra.sort }


def plot_intra
  gp = IO.popen('gnuplot', 'w')
  gp.puts "set output 'det.png'"
#  gp.puts "set title 'DET Curve'"
#  gp.puts "set format '%.2f'"
#  gp.puts "set xrange [0.001:100.5]"
#  gp.puts "set yrange [0.001:100.5]"
#  gp.puts "set xtics 10 nomirror"
#  gp.puts "set ytics 10 nomirror"
#  style.each { |s| gp.puts s }
#  gp.puts "set xlabel 'False Match Rate (FMR in %)'"
#  gp.puts "set ylabel 'False Non-Match Rate (FNMR in %)'"
#  gp.puts "set logscale"
  gp.puts "plot 'intra_dists.txt' u 1 w histograms title 'intra'"
end

plot_intra
