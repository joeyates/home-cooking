home = "/#{ node.user.home_root }/#{ node.user.name }"

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

