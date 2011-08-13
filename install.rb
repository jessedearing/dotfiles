require 'fileutils'

all_files = Dir['*']
home_dir = ENV['HOME'] || File.expand_path('~')

all_files.each do |file|
  home_file = File.join(home_dir, ".#{file}")
  FileUtils.ln_s file, home_file unless File.exists?(home_file) || File.directory?(file)
end
