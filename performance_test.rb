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


# This class processes the result files for arbitrary algorithms. The files must contain the genuine and impostor comparison strings, respectively.
# It extracts the scores and rounds them two 2 decimals in order to build a histogram.
# Based on the histogram, the error rates are computed. With this data, it is possible to plot three graph types: histogram, error rates distrubution and an roc curve.
class ResultsAnalyzer

  attr_reader :algos, :eer
  
  def initialize(datafiles=nil)
    @datafiles = datafiles # e.g. matches/masek_genuines.txt and matches/masek_impostors.txt
    @datafiles_grouped_by_algo = @datafiles.group_by { |v| File.basename(v).split('_').first } # {"masek"=>["matches/masek_genuines.txt", "matches/masek_impostors.txt"], "projectiris"=>["matches/projectiris_genuines.txt", "matches/projectiris_impostors.txt"]}
    @algos = Set.new # masek and projectiris
    @eer = {} # Equal Error Rate
    reset
  rescue Errno::ENOENT
    print "Data file not found.\n"
    print "Example usage: ./performance_test matches/*\n"
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
  
  def range(values)
    values.minmax
  end
  
  def mean(values, count)
    values.reduce(:+)/count
  end
  
  def median(values)
    sorted = values.sort
    len = sorted.length
    return (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
  end
  
  def variance(values, mean, count)
    values.inject(0) { |sum, s| sum + (s-mean)**2 }/count
  end
  
  def std_dev(variance)
    variance**0.5
  end
  
  def print_stats(outfile)
    File.open(outfile,'w') do |file|
      g_values, i_values = [], []
      @histogram[:genuines].map { |k,v| v.times { g_values << k.round(2) }}
      @histogram[:impostors].map { |k,v| v.times { i_values << k.round(2) }}
      g_range = range(g_values)
      i_range = range(i_values)
      g_count, i_count = g_values.length.to_f, i_values.length.to_f
      g_median, i_median = median(g_values), median(i_values)
      g_mean, i_mean = mean(g_values, g_count), mean(i_values, i_count)
      g_variance, i_variance = variance(g_values, g_mean, g_count), variance(i_values, i_mean, i_count)
      g_std_dev, i_std_dev = std_dev(g_variance), std_dev(i_variance)
      ["genuines", "impostors"].each do |x|
        file.puts(x)
        prefix = x[0]
        file.print "Range:".ljust(15), eval("#{prefix}_range[0]"), " to ", eval("#{prefix}_range[1]"), "\n"
        file.print "Median:".ljust(15), eval("#{prefix}_median"), "\n"
        file.print "Mean:".ljust(15), eval("#{prefix}_mean"), "\n"
        file.print "Variance:".ljust(15), eval("#{prefix}_variance"), "\n"
        file.print "Std. dev.:".ljust(16), eval("#{prefix}_std_dev"), "\n\n"
      end
    end
  end
  
  def histogram
    @datafiles_grouped_by_algo.each do |algo,files| #algo = masek/projectiris
      print "Processing results for #{algo}\n"
      @algos << algo
      reset
      @datafiles_grouped_by_algo[algo].sort!
      files.each do |file|
        dists = []
        key = file =~ /genuines/ ? :genuines : :impostors
        File.open(file, 'r').each_line { |line| dists << line.chomp.split('|').last.to_f.round(2) }
        dists.inject(@histogram[key]) { |h, e| h[e] += 1 ; h }
      end
      print "  Building histogram...\n"
      File.open("results/histogram_#{algo}",'w') do |file|
        101.times do |i|
          key = i.to_f/100
          file.print "#{@histogram[:genuines][key]} #{@histogram[:impostors][key]}\n"
        end
      end
      print_stats("results/stats_#{algo}")
      error_rates(algo)
    end
    File.open('results/eer', 'w') do |file|
      @eer.each do |algo, values|
        file.puts algo
        file.print "Threshold:".ljust(15), values[:index]/100.0, "\n"
        file.print "Error rate:".ljust(15), values[:eer], "\n\n"
      end
    end
  end
  
  def error_rates(algo)
    print "  Computing error rates...\n"
    values = @histogram[:impostors].values
    tmp_sum = 0
    error_rate(:impostors) { |i| tmp_sum += values[i-1]; @error_rates[:impostors][i] = tmp_sum }
    values = @histogram[:genuines].values
    tmp_sum = values.reduce(:+)
    error_rate(:genuines) { |i| tmp_sum -= values[i-1]; @error_rates[:genuines][i] = tmp_sum  }
    equal_error_rate(algo)
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
  
  # FVC2000
  def equal_error_rate(algo)
    t1, t2 = nil, nil
    count = @error_rates[:genuines].length
    min = { delta: 100.0, index: nil }
    delta = nil
    count.times do |i|
      delta = @error_rates[:genuines][i] - @error_rates[:impostors][i]
      t1 = i if delta >= 0
      t2 = i if delta <= 0
#      min = { delta: delta, index: i } if delta < min[:delta] and delta >= 0
#      print "i = #{i}, FNMR = #{@error_rates[:genuines][i]}, FMR = #{@error_rates[:impostors][i]}, delta = #{delta}\n"
    end
    t1_sum = @error_rates[:genuines][t1] + @error_rates[:impostors][t1]
    t2_sum = @error_rates[:genuines][t2] + @error_rates[:impostors][t2]
    t = t1_sum <= t2_sum ? t1 : t2
    eer_low, eer_high = @error_rates[:genuines][t], @error_rates[:impostors][t]
    eer = (eer_low + eer_high)/2.0
    result = { index: t, eer: eer}
    @eer.merge!({algo => result})
  end
end


class Plotter

  def initialize(algos=nil, eer=nil)
    @algos = algos
    @eer = eer
  end
  
  def style
    [ "set termoption dash",
    "fontsize(x)=((GPVAL_TERM eq 'postscript') && (strstrt(GPVAL_TERMOPTIONS,'eps')!=0)) ? x*2 : x",
#    "set terminal pngcairo dashed mono size 1024,768",# enhanced font 'Vera' 26",
    "set terminal pdfcairo dashed enh mono size 10in, 8in",# dashed mono size 1024,768",# enhanced font 'Vera' 26",
    "set termoption font 'Arial,15'",
    "set style line 80 lt rgb '#000000'", # Line style for axes
    "set style line 81 lt 0",
    "set style line 81 lt rgb '#808080'",
    "set style line 1 lt 3 lc rgb '#222222' lw 5",
    "set style line 2 lt 2 lc rgb '#222222' lw 5",
    "set style line 3 lt 0 lc rgb '#222222' lw 5",
    "set boxwidth 4 relative",
    "set border 3 back linestyle 80",
    "set grid back linestyle 81",
    "set mxtics 10",
    "set mytics 10",
    "set xtics font ',20'",
    "set ytics font ',20'",
    "set xlabel font ', 20'",
    "set ylabel font ', 20'",
    "set key samplen 2 spacing 2 tmargin font ', 20'",
#    "set lmargin at screen 0.10",
#    "set rmargin at screen 0.95",
#    "set bmargin at screen 0.1"
    ]
  end

  def histogram(algo)
    print "  Histogram...\n"
    plot({title: "Histogram", xlabel: "Hamming distance", ylabel: "Frequency", filename_prefix: "histogram_#{algo}", logscale: "y", xrange: "[-1:101]", yrange: "[0.1:2000]", xtics: "('0' 0, '0.1' 10, '0.2' 20, '0.3' 30, '0.4' 40, '0.5' 50, '0.6' 60, '0.7' 70, '0.8' 80, '0.9' 90, '1' 100)", ytics: "10" }) do
      #"plot 'results/histogram_#{algo}' u 2 w histograms fs transparent pattern 3 title 'impostors', '' u 1 w histograms fs transparent pattern 2 title 'genuines'"
      "plot 'results/histogram_#{algo}' u 2 w histograms lc rgb '#77999999' title 'impostors', '' u 1 w histograms lc rgb '#77222222' title 'genuines'"    end
  end
  
  def error_rates(algo)
    print "  Error distributions...\n"
    plot({title: "Error distributions", xlabel: "Threshold", ylabel: "Error (%)", filename_prefix: "distributions_#{algo}", logscale: false, xrange: "[0:100]", yrange: "[0:100]", xtics: "('0' 0, '0.1' 10, '0.2' 20, '0.3' 30, '0.4' 40, '0.5' 50, '0.6' 60, '0.7' 70, '0.8' 80, '0.9' 90, '1' 100)", ytics: "10" }) do
      "set label 1 'EER' at #{@eer[algo][:index]-10},85 tc lt 1; set arrow from #{@eer[algo][:index]},graph(0,0) to #{@eer[algo][:index]},graph(1,1) nohead lc rgb '#ff0000' lw 7; plot 'results/error_rates_#{algo}' u 1 w l ls 1 title 'FNMR(t)', '' u 2 w l ls 2 title 'FMR(t)'"
    end
  end
  
  def roc(cmd)
    print "Plotting ROC...\n"
    plot({title: "ROC Curve", xlabel: "False Match Rate FMR(t)", ylabel: "Verification rate (100-FNMR(t))", filename_prefix: "roc", logscale: false, xrange: "[0:100]", yrange: "[70:100]", xtics: "10", ytics: "('70' 70, '80' 80, '90' 90, '100' 100)" }) do
      "plot #{cmd}"
    end
  end
  
  def det(cmd)
    print "Plotting DET...\n"
    plot({title: "DET Curve", xlabel: "FMR(t)", ylabel: "FNMR(t)", filename_prefix: "det", logscale: false, xrange: "[0:100]", yrange: "[0:100]", xtics: "10", ytics: "10" }) do
      "plot #{cmd}"
    end
  end
  
  def plot_graphs
    roc_cmd, det_cmd = "", ""
    @algos.each_with_index do |algo, index|
      print "Plotting graphs for #{algo}\n"
      histogram(algo)
      error_rates(algo)      
      roc_cmd << "'results/error_rates_#{algo}' u 2:(100-$1) w l ls #{(index+1)%5} title '#{algo}'"
      roc_cmd << ", " unless index == (@algos.length-1)
      det_cmd << "'results/error_rates_#{algo}' u 2:1 w l ls #{(index+1)%5} title '#{algo}'"
      det_cmd << ", " unless index == (@algos.length-1)
    end
    roc(roc_cmd)
    det(det_cmd)
  end

  def plot(data, &plot_cmd)
    gp = IO.popen('gnuplot', 'w')
    gp.puts "set xlabel '#{data[:xlabel]}'"
    gp.puts "set ylabel '#{data[:ylabel]}'"
    filename = "#{data[:filename_prefix]}.pdf"
    gp.puts "set output '/home/giorgos/hda/SS13/bio/Ausarbeitung/_images/#{filename}'"#'results/#{filename}'"
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
p = Plotter.new(ra.algos, ra.eer)
p.plot_graphs
