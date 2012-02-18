# TODO: Manage SHA-1s
HOME="/home/#{ node[:user][:name] }"
%w(.bashrc .gemrc .gitconfig .gitexcludes .irbrc .rvmrc .screenrc .zshrc).each do | rc |
  template "#{ HOME }/#{ rc }" do
    mode '0644'
  end
end

