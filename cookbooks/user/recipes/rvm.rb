home = "/#{ node.user.home_root }/#{ node.user.name }"

execute 'install' do
  command 'curl -L get.rvm.io | bash -s stable'
  creates "#{ home }/.rvmrc"
end

