#!/usr/bin/env ruby

require 'fileutils'
require 'set'

class FullResultsAnalyzer
  
  def initialize(datafile=nil)
    @datafile = File.open(datafile, 'r')
    @histogram, @error_rates = {genuines: {}, impostors: {}}, {genuines: {}, impostors: {}}
    101.times do |i|
      key = (i.to_f/100)
      @histogram.each { |k,v| @histogram[k][key] = 0 }
      @error_rates.each { |k,v| @error_rates[k][key] = 0.0 }
    end
  rescue Errno::ENOENT
    print "Data file not found.\n"      
    exit
  end
  
  def histogram
    genuines, impostors = [],[]
    regex = /_1_1.bmp/
    @datafile.each_line do |line|
      left, right, dist = line.chomp.split('|')
      next if left >= right
      left_person, right_person = left.split('_').first, right.split('_').first
      if left_person == right_person
        genuines << dist.to_f.round(2)
      else
        next unless left =~ regex and right =~ regex
        impostors << dist.to_f.round(2)
      end
    end
    genuines.inject(@histogram[:genuines]) { |h, e| h[e] += 1 ; h }
    impostors.inject(@histogram[:impostors]) { |h, e| h[e] += 1 ; h }
    File.open("histogram_#{@datafile.path}",'w') do |file|
      101.times do |i|
        key = i.to_f/100
        file.print "#{@histogram[:genuines][key]} #{@histogram[:impostors][key]}\n"
      end
    end
  end
  
  def error_rates
    values = @histogram[:impostors].values
    tmp_sum = 0
    error_rate(:impostors) { |i| tmp_sum += values[i-1]; @error_rates[:impostors][i] = tmp_sum }
    values = @histogram[:genuines].values
    tmp_sum = values.reduce(:+)
    error_rate(:genuines) { |i| tmp_sum -= values[i-1]; @error_rates[:genuines][i] = tmp_sum  }
    File.open("error_rates_#{@datafile.path}", 'w') do |file|
      [@error_rates[:genuines], @error_rates[:impostors]].transpose.each { |g,i| file.puts "#{g} #{i}" }
    end
  end
  
  def error_rate(key)
    @error_rates[key] = []
    total = @histogram[key].values.reduce(:+)
    @error_rates[key][0] = (key == :genuines) ? total : 0
    @error_rates[key][100] = (key == :genuines) ? 0 : total
    1.upto(99) { |i| yield(i) }
    @error_rates[key].map! { |value| 100*value.to_f/total }
  end  
end


class ResultsAnalyzer

  attr_reader :algos
  
  def initialize(datafiles=nil)
    @datafiles = datafiles
    @datafiles_grouped_by_algo = @datafiles.group_by { |v| File.basename(v).split('_').first }    
    @algos = Set.new
    reset
  rescue Errno::ENOENT
    print "Data file not found.\n"      
    exit
  end
  
  def reset
    @histogram, @error_rates = {genuines: {}, impostors: {}}, {genuines: {}, impostors: {}}
    101.times do |i|
      key = (i.to_f/100)
      @histogram.each { |k,v| @histogram[k][key] = 0 }
      @error_rates.each { |k,v| @error_rates[k][key] = 0.0 }
    end
  end
  
  def histogram
    @datafiles_grouped_by_algo.each do |algo,files| #algo = matlab/projectiris
      @algos << algo
      reset
      @datafiles_grouped_by_algo[algo].sort!
      files.each do |file|
        dists = []
        key = file =~ /genuines/ ? :genuines : :impostors
        File.open(file, 'r').each_line { |line| dists << line.chomp.split('|').last.to_f.round(2) }
        dists.inject(@histogram[key]) { |h, e| h[e] += 1 ; h }
      end
      File.open("results/histogram_#{algo}",'w') do |file|
        101.times do |i|
          key = i.to_f/100
          file.print "#{@histogram[:genuines][key]} #{@histogram[:impostors][key]}\n"
        end
      end
      error_rates(algo)
    end
  end
  
  def error_rates(algo)
    values = @histogram[:impostors].values
    tmp_sum = 0
    error_rate(:impostors) { |i| tmp_sum += values[i-1]; @error_rates[:impostors][i] = tmp_sum }
    values = @histogram[:genuines].values
    tmp_sum = values.reduce(:+)
    error_rate(:genuines) { |i| tmp_sum -= values[i-1]; @error_rates[:genuines][i] = tmp_sum  }
    File.open("results/error_rates_#{algo}", 'w') do |file|
      [@error_rates[:genuines], @error_rates[:impostors]].transpose.each { |g,i| file.puts "#{g} #{i}" }
    end
  end
  
  def error_rate(key)
    @error_rates[key] = []
    total = @histogram[key].values.reduce(:+)
    @error_rates[key][0] = (key == :genuines) ? total : 0
    @error_rates[key][100] = (key == :genuines) ? 0 : total
    1.upto(99) { |i| yield(i) }
    @error_rates[key].map! { |value| 100*value.to_f/total }
  end  
end


class Plotter

  def initialize(algos=nil)
    @algos = algos
  end
  
  def style
    [ "set termoption dash",
    "set terminal pngcairo dashed mono size 1024,768",# enhanced font 'Vera' 26",
    "set style line 80 lt rgb '#000000'", # Line style for axes
    "set style line 81 lt 0",
    "set style line 81 lt rgb '#808080'",
    "set style line 1 lt 3 lc rgb '#222222' lw 3",
    "set style line 2 lt 2 lc rgb '#222222' lw 3",
    "set style line 3 lt 0 lc rgb '#222222' lw 3",
    "set boxwidth 4 relative",
    "set border 3 back linestyle 80",
    "set grid back linestyle 81",
    "set mxtics 10",
    "set mytics 10",
    "set xtics font ',18'",
    "set ytics font ',18'",
    "set xlabel font ', 20'",
    "set ylabel font ', 20'",
    "set key samplen 2 spacing 2 tmargin font ', 20'"
#    "set lmargin at screen 0.10",
#    "set rmargin at screen 0.95",
#    "set bmargin at screen 0.1"
    ]
  end

  def histogram(algo)
    plot({title: "Histogram", xlabel: "Hamming distance", ylabel: "Frequency", filename_prefix: "histogram_#{algo}", logscale: "y", xrange: "[-1:101]", yrange: "[0.1:1000]", xtics: "('0' 0, '0.1' 10, '0.2' 20, '0.3' 30, '0.4' 40, '0.5' 50, '0.6' 60, '0.7' 70, '0.8' 80, '0.9' 90, '1' 100)", ytics: "10" }) do
      "plot 'results/histogram_#{algo}' u 2 w histograms fs transparent pattern 1 title 'impostors', '' u 1 w histograms fs transparent pattern 2 title 'genuines'"
    end
  end
  
  def error_rates(algo)
    plot({title: "Error distributions", xlabel: "Threshold", ylabel: "Error (%)", filename_prefix: "distributions_#{algo}", logscale: false, xrange: "[0:100]", yrange: "[0:100]", xtics: "('0' 0, '0.1' 10, '0.2' 20, '0.3' 30, '0.4' 40, '0.5' 50, '0.6' 60, '0.7' 70, '0.8' 80, '0.9' 90, '1' 100)", ytics: "10" }) do
      "plot 'results/error_rates_#{algo}' u 1 w l ls 1 title 'FNMR(t)', '' u 2 w l ls 2 title 'FMR(t)'"
      end
  end
  
  def roc(cmd)
    plot({title: "ROC Curve", xlabel: "FMR", ylabel: "100-FMR", filename_prefix: "roc", logscale: "xy", xrange: "[0.01:100]", yrange: "[70:100]", xtics: "10", ytics: "('70' 70, '100' 100)" }) do
      "plot #{cmd}"
    end
  end
  
  def plot_graphs
    roc_cmd = ""
    @algos.each_with_index do |algo, index|
      histogram(algo)
      error_rates(algo)      
      roc_cmd << "'results/error_rates_#{algo}' u 2:(100-$1) w l ls #{(index+1)%5} title '#{algo}'"
      roc_cmd << ", " unless index == (@algos.length-1) 
    end
    roc(roc_cmd)
  end

  def plot(data, &plot_cmd)
    gp = IO.popen('gnuplot', 'w')
    gp.puts "set xlabel '#{data[:xlabel]}'"
    gp.puts "set ylabel '#{data[:ylabel]}'"
    filename = "#{data[:filename_prefix]}.png"
    gp.puts "set output 'results/#{filename}'"
    gp.puts "set xrange #{data[:xrange]}" if data[:xrange]
    gp.puts "set yrange #{data[:yrange]}" if data[:yrange]
    gp.puts "set xtics #{data[:xtics]} nomirror" if data[:xtics]
    gp.puts "set ytics #{data[:ytics]} nomirror" if data[:ytics]
    gp.puts "set logscale #{data[:logscale]}" if data[:logscale]
    gp.puts "set style fill transparent solid 0.5 noborder"
    style.each { |s| gp.puts s }
    gp.puts "set key #{data[:key]}" if data[:key]
    gp.puts yield
  end
  
  
end


ra = ResultsAnalyzer.new(ARGV)
ra.histogram
p = Plotter.new(ra.algos)
p.plot_graphs
