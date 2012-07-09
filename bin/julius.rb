#!/usr/bin/env ruby
gem 'activesupport', '~> 3.2.3'
require 'active_support'
require 'active_support/core_ext'
require 'active_support/time_with_zone'

if ARGV.empty?
  d = Time.now
else
  d = Time.parse("#{ARGV[0]} #{ARGV[1] || "12:00am"}")
end

Time.zone = "America/Chicago"
puts "Time for me: #{d.inspect}"
puts "Time for Julius: #{(d.in_time_zone("Asia/Manila")).inspect}"
