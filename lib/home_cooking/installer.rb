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
      session.sudo 'apt-get update'
      # Dependencies
      session.sudo 'apt-get -y install git-core ruby rubygems'
      session.sudo 'gem install net-ssh chef --no-ri --no-rdoc'
    end

    def create_user
      raise 'new_user not set' if @new_user.nil?

      session.sudo 'groupadd admin'
      session.sudo "useradd --create-home --groups=admin #{ @new_user[ :username ] }"
      session.prompts[ '(Enter|Retype) new UNIX password' ] = @new_user[ :password ]
      session.sudo "passwd #{ @new_user[ :username ] }"

      new_user_session = Remote::Session.new( @host, :username => @new_user[ :username ],
                                                     :password => @new_user[ :password ],
                                                     :port     => @port )
      new_user_session.run 'git clone git://github.com/joeyates/home-cooking.git .home-cooking'
      new_user_session.close
    end

    def install
      session.sudo [
        "cd /home/#{ @new_user[ :username ] }/.home-cooking",
        "sed 's/\\/username\\//\\/#{ @new_user[ :username ] }\\//g' chef-solo.rb.template > chef-solo.rb",
        "sed 's/\\/username\\//\\/#{ @new_user[ :username ] }\\//g' attributes.js.template > attributes.js",
        "sed -i 's/\\/usergroup\\//\\/#{ @new_user[ :username ] }\\//g' attributes.js",
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

