lib_directory = File.expand_path( '../../../lib', File.dirname( __FILE__ ) )
$LOAD_PATH.unshift( lib_directory )

require 'home_cooking'

HOME = "/home/#{ node[:user][:name] }"

%w(.bashrc .gemrc .gitconfig .gitexcludes .irbrc .rvmrc .screenrc .zshrc).each do | rc |
  destination = "#{ HOME }/#{ rc }"
  template destination do
    mode '0644'
    owner 'joe'
    group 'joe'
  end

  file = HomeCooking::File.new( destination )
  if file.modified?
    puts "File '#{ destination }' has been modified"
  else
    file.stamp! unless file.stamped?
  end
end

