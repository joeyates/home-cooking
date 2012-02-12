=begin

1. Environment setup:

# HOME_COOKING_USER must have sudo rights
export HOME_COOKING_USER=user
export HOME_COOKING_HOST=the.remote.host

export GIT_USER=joeyates
export GIT_REPO=home-cooking
export HOME_COOKING_KEYNAME=id_$HOME_COOKING_HOST
export HOME_COOKING_KEYNAME_PATH=~/.ssh/$HOME_COOKING_KEYNAME

export HOME_COOKING_DATA_BAG_KEY=.${HOME_COOKING_HOST}_data_bag_key
export HOME_COOKING_DATA_BAG_KEY_PATH=~/$HOME_COOKING_DATA_BAG_KEY

2. Setup Passwordless Access to root
i. Create a keypair:
ssh-keygen -f $HOME_COOKING_KEYNAME_PATH -N ''

ii. Install public key
ssh-copy-id -i $HOME_COOKING_KEYNAME_PATH $HOME_COOKING_USER@$HOME_COOKING_HOST
scp $HOME_COOKING_KEYNAME_PATH.pub $HOME_COOKING_USER@$HOME_COOKING_HOST:
ssh -t $HOME_COOKING_USER@$HOME_COOKING_HOST "sudo sh -c 'cd /root && mkdir -p .ssh && chmod 0700 .ssh && touch .ssh/authorized_keys && chmod 0600 .ssh/authorized_keys && cat /home/$HOME_COOKING_USER/$HOME_COOKING_KEYNAME.pub >> .ssh/authorized_keys' && rm ~/$HOME_COOKING_KEYNAME.pub"

3. Install ruby and chef-solo

gem install capistrano
cap chef:bootstrap

4. Project setup: data bag key
 
openssl rand -base64 512 | tr -d '\r\n' > $HOME_COOKING_DATA_BAG_KEY_PATH
chmod 0600 $HOME_COOKING_DATA_BAG_KEY_PATH

5. Edit secret data

6. Run chef-solo

TODO: create local tarball, upload it and use that
 $ cap chef:run_recipes

=end

role :target,   ENV[ 'HOME_COOKING_HOST' ]
set  :user,     'root'

namespace :chef do

  desc 'Install minimal setup on remote machine'
  task :bootstrap, :roles => :target do
    raise "HOME_COOKING_DATA_BAG_KEY_PATH not set" unless ENV[ 'HOME_COOKING_DATA_BAG_KEY_PATH' ]
    raise "HOME_COOKING_DATA_BAG_KEY_PATH file does not exist" unless File.exist?( ENV[ 'HOME_COOKING_DATA_BAG_KEY_PATH' ] )
    update_packages
    install_build_tools
    install_ruby
    install_gems
    install_chef_solo
  end

  desc 'Run chef-solo'
  task :run_recipes, :roles => :target do
    run "chef-solo -r https://github.com/#{github_user}/#{github_repo}/raw/master/chef-solo.tar.gz"
  end

  task :update_packages do
    run 'apt-get update'
  end

  task :install_ruby do
    # oneiric has ruby 1.9.2
    run 'apt-get install -y ruby1.9.2-full gcc'
    # packages < oneiric: libreadline6-dev libssl-dev libsqlite3-dev zlib1g-dev libyaml-dev curl
  end

  task :install_build_tools do
    run 'apt-get install -y gcc make'
  end

  task :install_gems do
    put gemrc, '/root/.gemrc'
    run 'gem install chef'
  end

  task :install_chef_solo do
    directory '/etc/chef'
    directory '/var/chef-solo'
    put etc_chef_solo_rb, '/etc/chef/solo.rb'
    put etc_chef_host_json, '/etc/chef/host.json'
    put File.read( ENV[ 'HOME_COOKING_DATA_BAG_KEY_PATH' ] ), '/root/home_cooking_data_bag_key'
    run 'chmod 0600 /root/home_cooking_data_bag_key'
  end

end

def directory( path )
  run "mkdir -p #{ path }"
end

def gemrc
  <<-EOT
search:  --remote
install: --no-rdoc --no-ri
  EOT
end

def etc_chef_solo_rb
  github_user = ENV[ 'GIT_USER' ] or raise "Set GIT_USER"
  github_repo = ENV[ 'GIT_REPO' ] or raise "Set GIT_REPO"

  <<-EOT
file_cache_path "/var/chef-solo"
cookbook_path "/var/chef-solo/cookbooks"
data_bag_path "/var/chef-solo/data_bags"
json_attribs "/etc/chef/host.json"
recipe_url "https://github.com/#{github_user}/#{github_repo}/raw/master/chef-solo.tar.gz"
  EOT
end

def etc_chef_antani_json
  home_cooking_host = ENV[ 'HOME_COOKING_HOST' ]
  <<-EOT
{
 "name": "#{home_cooking_host}",
 "description": "#{home_cooking_host} VPS",
 "run_list": [ "recipe[user]" ]
}
  EOT
end

