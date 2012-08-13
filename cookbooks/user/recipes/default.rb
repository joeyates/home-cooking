project_root  = File.expand_path( File.join( '..', '..', '..' ), File.dirname( __FILE__ ) )
lib_directory = File.expand_path( 'lib', project_root )
$LOAD_PATH.unshift( lib_directory )

require 'home-cooking'

home = "/#{ node.user.home_root }/#{ node.user.name }"

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

group 'admin' do
  members [ node.user.name ]
end

%w( ack-grep aptitude curl mercurial trash-cli vim-gnome zsh ).each do | p |
  package p do
    action :install
  end
end

%w(.gemrc .gitconfig .gitexcludes .irbrc .screenrc .zshrc).each do | rc |
  destination = "#{ home }/#{ rc }"
  template destination do
    action :create_if_missing
    mode '0644'
    owner node.user.name
    group node.user.group
  end
  apply_home_cooking_sha1_stamp destination
end

directory "#{ home }/bin" do
  owner node.user.name
  group node.user.group
  mode '0755'
end

%w(bundler-exec duse home-cooking scm_screen_info vimx).each do | name |
  destination = "#{ home }/bin/#{ name }"
  template destination do
    source "bin/#{ name }.erb"
    action :create_if_missing
    mode '0755'
    owner node.user.name
    group node.user.group
  end
  apply_home_cooking_sha1_stamp destination
end

git "#{ home }/.vim" do
  repository 'git://github.com/joeyates/vimrc.git'
  revision   'master'
  action     :sync
  user       node.user.name
  group      node.user.name
end

link "#{ home }/.vimrc" do
  to "#{ home }/.vim/vimrc"
end

include_recipe 'user::rbenv'

