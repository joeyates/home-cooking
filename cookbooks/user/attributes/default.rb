case os
when 'darwin'
  set[ :user ][ :home_root ] = 'Users'
when 'linux'
  set[ :user ][ :home_root ] = 'home'
end

