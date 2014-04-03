if defined?(::Bundler)
  ruby_version = if RUBY_VERSION < '2.0'
                   '1.9.1'
                 else
                   '2.0.0'
                 end
  global_path = File.expand_path("../../lib/ruby/gems/#{ruby_version}/gems", `rbenv which ruby`.chomp)
  [:wirble, :awesome_print, :'pry-nav'].each do |gem|
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

# Blatently stolen from @duien (https://github.com/duien/dotfiles/blob/master/home/.pryrc)
if `git rev-parse --is-inside-work-tree 2>&1`.strip == "true"
  Pry.config.prompt_name = `basename \`git rev-parse --show-toplevel\``.strip
elsif Pry.config.prompt_name == 'pry'
  Pry.config.prompt_name = nil
end

def rails_sym
  defined?(Rails) ? '⌗ ' : ''
end

Pry.prompt = [
  proc { |target_self, nest_level, pry|
    "\001\e[0;40m\002 #{pry.input_array.size}" + # line number on black
    " \001\e[0;30;41m\002 " + # black to red triange
    "#{rails_sym + Pry.config.prompt_name + '  ' if Pry.config.prompt_name}" + # optional prompt name
    "#{Pry.view_clip(target_self)}#{":#{nest_level}" unless nest_level.zero?} " +
    "\001\e[0;31m\002 \001\e[0m\002" # close red and reset color
  },
  proc { |target_self, nest_level, pry|
    " #{pry.input_array.size}  #{rails_sym + Pry.config.prompt_name + '  ' if Pry.config.prompt_name }#{Pry.view_clip(target_self)}#{":#{nest_level}" unless nest_level.zero?} ".gsub(/./, ' ') +
    "\001\e[0;31m\002 " + # a red triange
    "\001\e[0m\002" # reset color
  }
]
