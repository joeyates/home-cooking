#!/usr/bin/env ruby

=begin

The test assumes that:
- a Virtual Box vm is running,
- the vm has a user called 'user' with password 'password',
- 'user' has sudo permissions for all commands.
- the IP of the VM is passed in as the first parameter to this script

=end

lib_directory = File.expand_path( '../lib', File.dirname( __FILE__ ) )
$LOAD_PATH.unshift( lib_directory )

require 'home_cooking/installer'

installer = HomeCooking::Installer.new( ARGV[ 0 ] )
install.existing_user = { :username => 'user', :password => 'password' }
install.new_user      = { :username => 'me',   :password => 'secret'   }

installer.prepare_system
installer.create_user
installer.install

