require 'date'
require 'optparse'

opt = OptionParser.new
params = {}

opt.on('-y year', 'like -y 2019, Please enter "year"') { |year| params[:year] = year }
opt.on('-m month', 'like -m 6, Please enter "month"') { |month| params[:month] = month }

opt.parse!(ARGV)

class MonthlyCalendar
  attr_reader :year, :month, :beginning_of_month, :end_of_month

  def initialize(year = Date.today.year, month = Date.today.month)
    @year = year.to_i
    @month = month.to_i
  end

  def beginning_of_month
    beginning_of_month ||= Date.new(year, month, 1)
  end

  def end_of_month
    end_of_month ||= Date.new(year, month, -1)
  end

  def show
    header
    previous_padding
    (beginning_of_month...end_of_month).each do |date|
      date.saturday? ? puts_day(date) : printf_day(date)
    end
    puts_day(end_of_month)
    footer
  end

  private
  def header
    puts "---" * 7
    puts "   " * 2 + " #{month}月 #{year} " + "   " * 2
    puts " 日 月 火 水 木 金 土"
  end
  
  def footer
    puts "---" * 7
  end

  def previous_padding
    printf '   ' * beginning_of_month.cwday.to_i unless beginning_of_month.sunday?
  end

  def puts_day(date)
    printf("%3d\n", date.day.to_s)
  end

  def printf_day(date)
    printf("%3d", date.day.to_s)
  end
end

monthly_calender = MonthlyCalendar.new(year = params[:year], month = params[:month])
monthly_calender.show