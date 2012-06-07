home = "/#{ node.user.home_root }/#{ node.user.name }"

git "#{ home }/.rbenv" do
  repository 'git://github.com/sstephenson/rbenv'
  revision   'master'
  action     :sync
  user       node.user.name
  group      node.user.name
end

directory "#{ home }/.rbenv/plugins" do
  owner node.user.name
  group node.user.group
  mode '0755'
end

git "#{ home }/.rbenv/plugins/ruby-build" do
  repository 'git://github.com/sstephenson/ruby-build'
  revision   'master'
  action     :sync
  user       node.user.name
  group      node.user.name
end

