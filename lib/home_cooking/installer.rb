require 'remote/session'

module HomeCooking

  class Installer

    attr_accessor :existing_user
    attr_accessor :new_user

    def initialize( host, options = {} )
      @host = host
      @port = options[ :port ] || 22
    end

    def prepare_system
      session.sudo [
        'apt-get update',
        'apt-get -y install git-core ruby rubygems', # Dependencies
        'gem install net-ssh chef remote-session --no-ri --no-rdoc'
      ]
    end

    def create_user
      raise 'new_user not set' if @new_user.nil?

      session.prompts[ '(Enter|Retype) new UNIX password' ] = @new_user[ :password ]
      session.sudo [
        "useradd --create-home #{ @new_user[ :username ] }",
        "passwd #{ @new_user[ :username ] }"
      ]
    end

    def install
      s = Remote::Session.new( @host, :username => @new_user[ :username ],
                                      :password => @new_user[ :password ],
                                      :port     => @port )
      s.run 'git clone git://github.com/joeyates/home-cooking.git .home-cooking'
      s.run "cd ~/.home-cooking && sed 's/\\/username\\//\\/#{ @new_user[ :username ] }\\//g' chef-solo.rb.template > chef-solo.rb"
      s.run "cd ~/.home-cooking && sed 's/\"username\"/\"#{ @new_user[ :username ] }\"/g' attributes.js.template > attributes.js"
      s.run "cd ~/.home-cooking && sed -i 's/\"usergroup\"/\"#{ @new_user[ :username ] }\"/g' attributes.js"
      s.close
    end

    def first_run
      session.sudo [
        "cd /home/#{ @new_user[ :username ] }/.home-cooking",
        'chef-solo -c chef-solo.rb -j attributes.js -u root'
      ]
    end

    private

    def session
      return @session if @session

      raise 'existing user not set' if @existing_user.nil?
 
      @session = Remote::Session.new( @host, :username      => @existing_user[ :username ],
                                             :password      => @existing_user[ :password ],
                                             :sudo_password => @existing_user[ :password ],
                                             :port          => @port )
    end

  end

end

