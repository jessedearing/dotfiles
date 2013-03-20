if defined?(::Bundler)
  global_path = File.expand_path('../../lib/ruby/gems/1.9.1/gems', `rbenv which ruby`.chomp)
  [:wirble, :awesome_print].each do |gem|
    path = Dir.glob("#{global_path}/*").grep(Regexp.new(gem.to_s)).first
    if path && !path.empty?
      $LOAD_PATH << "#{path}/lib"
    elsif ENV['GEM_HOME']
      # fall back to gem home
      home = Dir.glob("#{ENV['GEM_HOME']}/*").grep(Regexp.new(gem.to_s)).first
      if home
        $LOAD_PATH << "#{home}/lib"
      end
    end
  end
end

require 'rubygems' rescue nil
require 'wirble' rescue nil
require 'awesome_print' rescue nil

# load wirble
Wirble.init
Wirble.colorize

unless IRB.version.include?('DietRB')
  IRB::Irb.class_eval do
    def output_value
      ap @context.last_value
    end
  end
else # MacRuby
  IRB.formatter = Class.new(IRB::Formatter) do
    def inspect_object(object)
      object.ai
    end
  end.new
end

# load hirb

# IRB.conf[:AUTO_INDENT] = true

if ENV.include?('RAILS_ENV')
  if !Object.const_defined?('RAILS_DEFAULT_LOGGER')
    require 'logger'
    Object.const_set('RAILS_DEFAULT_LOGGER', Logger.new(STDOUT))
  end

  def sql(query)
    ActiveRecord::Base.connection.select_all(query)
  end
  
  if ENV['RAILS_ENV'] == 'test'
    require 'test/test_helper'
  end

# for rails 3
elsif defined?(Rails) && !Rails.env.nil? && defined?(ActiveRecord)
  if Rails.logger
    Rails.logger =Logger.new(STDOUT)
    ActiveRecord::Base.logger = Rails.logger
  end
  if Rails.env == 'test'
    require 'test/test_helper'
  end
else
  # nothing to do
end

if defined?(Mongoid)
  Mongoid.config.logger = Logger.new($stdout)
end

# annotate column names of an AR model
def show(obj)
  y(obj.send("column_names"))
end

