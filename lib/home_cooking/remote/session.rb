require 'rubygems' if RUBY_VERSION < '1.9'
require 'net/ssh'

module HomeCooking

  module Remote
    SUDO_PROMPT = 'sudo_prompt'

    class Session
      def initialize( host, user, password )
        @host, @user, @password = host, user, password
        connect!
      end

      def run( command )
        abort "Session is closed" if @session.nil?
        puts "@#{ @host }: #{ command }"
        puts @session.exec!( command )
      end

      def sudo( command, prompts = {} )
        abort "Session is closed" if @session.nil?
        puts "@#{ @host }: sudo #{ command }"
        @session.open_channel do | ch |
          ch.request_pty do | ch, success |
            if ! success
              abort "Could not obtain pty"
            end
          end

          ch.exec "sudo -p '#{ SUDO_PROMPT }' #{ command }" do | ch, success |
            abort "Could not execute sudo command: #{ command }" unless success

            ch.on_data do | ch, data |
              if data =~ Regexp.new( SUDO_PROMPT )
                ch.send_data "#{ @password }\n"
              else
                prompt_matched = false
                prompts.each_pair do | prompt, send |
                  if data =~ Regexp.new( prompt )
                    ch.send_data "#{ send }\n"
                    prompt_matched = true
                  end
                end
                puts data if ! prompt_matched
              end
            end

            ch.on_extended_data do | ch, type, data |
              abort "Error #{ data } while performing command: #{ command }"
            end
          end
        end
        @session.loop
      end

      def close!
        @session.close
        @session = nil
      end

      private

      def connect!
        @session = Net::SSH.start( @host, @user, :password => @password )
      end
    end

  end

end

