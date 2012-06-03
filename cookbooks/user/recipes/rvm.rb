home = "/#{ node.user.home_root }/#{ node.user.name }"

package 'curl' do
  action :install
end

execute 'install' do
  command 'curl -L get.rvm.io | bash -s stable'
  creates "#{ home }/.rvmrc"
end

