lib_directory = File.expand_path( '../../../lib', File.dirname( __FILE__ ) )
$LOAD_PATH.unshift( lib_directory )

require 'home_cooking'

HOME = "/#{ node.user.home_root }/#{ node.user.name }"

def apply_home_cooking_sha1_stamp( destination )
  ruby_block "apply_home_cooking_sha1_stamp" do
    block do
      file = HomeCooking::File.new( destination )
      if ! file.stamped?
        puts "File '#{ destination }' is not stamped"
        file.stamp!
      elsif file.modified?
        puts "File '#{ destination }' has been modified"
      end
    end
  end
end

%w(.gemrc .gitconfig .gitexcludes .irbrc .rvmrc .screenrc .zshrc).each do | rc |
  destination = "#{ HOME }/#{ rc }"
  template destination do
    action :create_if_missing
    mode '0644'
    owner node.user.name
    group node.user.group
  end
  apply_home_cooking_sha1_stamp destination
end

directory "#{ HOME }/bin" do
  owner node.user.name
  group node.user.group
  mode '0755'
end

%w(bundler-exec duse scm_screen_info vimx).each do | name |
  destination = "#{ HOME }/bin/#{ name }"
  template destination do
    source "bin/#{ name }.erb"
    action :create_if_missing
    mode '0755'
    owner node.user.name
    group node.user.group
  end
  apply_home_cooking_sha1_stamp destination
end

git "#{ HOME }/.vim" do
  repository 'git://github.com/joeyates/vimrc.git'
  revision   'master'
  action     :sync
  user       node.user.name
  group      node.user.name
end

link "#{ HOME }/.vimrc" do
  to "#{ HOME }/.vim/vimrc"
end

