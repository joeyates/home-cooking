set[ :user ][ :name ]          = 'joe'
case os
when 'darwin'
  set[ :user ][ :group ] = 'wheel' 
when 'linux'
  set[ :user ][ :group ] = 'joe'
end

