set[ :user ][ :name ]          = 'joe'
case os
when 'darwin'
  set[ :user ][ :home_root ] = 'Users'
  set[ :user ][ :group ]     = 'wheel'
when 'linux'
  set[ :user ][ :home_root ] = 'home'
  set[ :user ][ :group ]     = 'joe'
end

