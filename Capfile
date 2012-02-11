=begin

1. Environment setup:

 $ GIT_USER=joeyates
 $ GIT_REPO=home-cooking
 $ HOME_COOKING_HOST=the.remote.host
 $ HOME_COOKING_KEYNAME=.ssh/id_$HOME_COOKING_HOST
 $ DATA_BAG_KEY=${HOME_COOKING_HOST}_data_bag_key

Create a keypair:
 $ ssh-keygen -f $HOME_COOKING_KEYNAME -N ''
 
Create a key for encryptiing data bags:
 $ openssl rand -base64 512 | tr -d '\r\n' > $DATA_BAG_KEY

2. Setup public key authentication

 $ ssh root@$HOST "mkdir -p /root/.ssh && chmod 0700 /root/.ssh"
 $ ssh-copy-id -i $KEYNAME root@$HOST

3. Install ruby and chef-solo

 $ cap chef:bootstrap

4. Run chef-solo

 $ cap chef:run_recipes

=end

role :target,   ENV[ 'HOME_COOKING_HOST' ]
set  :user,     'root'

namespace :chef do

  desc 'Install minimal setup on remote machine'
  task :bootstrap, :roles => :target do
    raise "DATA_BAG_KEY not set" unless ENV[ 'DATA_BAG_KEY' ]
    raise "DATA_BAG_KEY file does not exist" unless File.exist?( ENV[ 'DATA_BAG_KEY' ] )
    install_dependencies
    ruby193
    gems
    install_chef_solo
  end

  desc 'Run chef-solo'
  task :run_recipes, :roles => :target do
    run 'chef-solo -r https://github.com/#{github_user}/#{github_repo}/raw/master/chef-solo.tar.gz'
  end

  task :install_dependencies do
    run "apt-get update"
    run "apt-get install -y libreadline5-dev libssl-dev libsqlite3-dev zlib1g-dev libyaml-dev curl"
  end

  task :ruby193 do
    directory '/root/build'
    run 'cd /root/build && curl -O -# http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p0.tar.gz'
    run 'cd /root/build && tar xf ruby-1.9.3-p0.tar.gz'
    run 'cd /root/build/ruby-1.9.3-p0 && ./configure --prefix=/usr'
    run 'cd /root/build/ruby-1.9.3-p0 && make'
    run 'cd /root/build/ruby-1.9.3-p0 && make install'
    run 'rm -rf /root/build'
  end

  task :gems do
    put gemrc, '/root/.gemrc'
    run 'gem install chef'
  end

  task :install_chef_solo do
    directory '/etc/chef'
    directory '/var/chef-solo'
    put etc_chef_solo_rb, '/etc/chef/solo.rb'
    put etc_chef_host_json, '/etc/chef/host.json'
    put File.read( ENV[ 'DATA_BAG_KEY' ] ), '/root/home_cooking_data_bag_key'
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
  github_user = ENV[ 'GIT_USER' ] || raise "Set GIT_USER"
  github_repo = ENV[ 'GIT_REPO' ] || raise "Set GIT_REPO"
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
 "run_list": [ "recipe[home-cooking]" ]
}
  EOT
end

