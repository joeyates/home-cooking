template "/home/#{ node[:user][:name] }/.zshrc" do
  source 'zshrc'
  mode '0644'
end

