=begin

1. Passwordless Access

# HOME_COOKING_USER must have sudo rights
export HOME_COOKING_USER=user
export HOME_COOKING_HOST=the.remote.host

export HOME_COOKING_KEYNAME=id_$HOME_COOKING_HOST
export HOME_COOKING_KEYNAME_PATH=~/.ssh/$HOME_COOKING_KEYNAME

i. Create a keypair:

ssh-keygen -f $HOME_COOKING_KEYNAME_PATH -N ''

ii. Install public key

ssh-copy-id -i $HOME_COOKING_KEYNAME_PATH $HOME_COOKING_USER@$HOME_COOKING_HOST

2. Install Chef

ssh -t $HOME_COOKING_USER@$HOME_COOKING_HOST "sudo su -"
apt-get update
# oneiric has ruby 1.9.2
apt-get install -y ruby1.9.2-full gcc
# packages < oneiric: libreadline6-dev libssl-dev libsqlite3-dev zlib1g-dev libyaml-dev curl
# install: git
apt-get install -y gcc make

def gemrc
  <<-EOT
search:  --remote
install: --no-rdoc --no-ri
  EOT
end
    put gemrc, '/root/.gemrc'
    run 'gem install chef'
    directory '/etc/chef'
    directory '/var/chef-solo'

export GIT_USER=joeyates
export GIT_REPO=home-cooking

  <<-EOT
file_cache_path "/var/chef-solo"
cookbook_path "/var/chef-solo/cookbooks"
data_bag_path "/var/chef-solo/data_bags"
json_attribs "/etc/chef/host.json"
recipe_url "https://github.com/#{GIT_USER}/#{GIT_REPO}/raw/master/chef-solo.tar.gz"
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

    put etc_chef_solo_rb, '/etc/chef/solo.rb'
    put etc_chef_host_json, '/etc/chef/host.json'
    put File.read( ENV[ 'HOME_COOKING_DATA_BAG_KEY_PATH' ] ), '/root/home_cooking_data_bag_key'
    run 'chmod 0600 /root/home_cooking_data_bag_key'

3. Install

export HOME_COOKING_DATA_BAG_KEY=.${HOME_COOKING_HOST}_data_bag_key
export HOME_COOKING_DATA_BAG_KEY_PATH=~/$HOME_COOKING_DATA_BAG_KEY

download repo
run chef-repo

4. Modify
 
openssl rand -base64 512 | tr -d '\r\n' > $HOME_COOKING_DATA_BAG_KEY_PATH
chmod 0600 $HOME_COOKING_DATA_BAG_KEY_PATH

