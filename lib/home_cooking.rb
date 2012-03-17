require 'home_cooking/remote/session'

module HomeCooking

  def ask( prompt )
    print prompt
    gets.chomp
  end

  def ask_password( prompt )
    `stty -echo`
    password = ask( prompt )
    `stty echo`
    puts
    password
  end

end

