require 'fileutils'

def link_file(home_file, file)
  if File.exists?(home_file)
    return "file exists"
  else
    FileUtils.ln_s File.expand_path(file), home_file
    return "done"
  end
end

task :default => :install

desc 'Symlink dotfiles to users home directory'
task :install do
  all_files = Dir['*']
  home_dir = ENV['HOME'] || File.expand_path('~')

  all_files.delete(File.basename(__FILE__))

  all_files.each do |file|
    home_file = File.join(home_dir, ".#{file}")
    puts "Linking #{file} to #{home_file}"
    puts link_file(home_file, file)
  end
end
