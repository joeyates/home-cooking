#!/usr/bin/env ruby

lib_directory = File.expand_path( '../lib', File.dirname( __FILE__ ) )
$LOAD_PATH.unshift( lib_directory )

require 'home_cooking/installer'
require 'vagrant'

env         = Vagrant::Environment.new
vm_config   = env.primary_vm.config
host        = vm_config.ssh.host
port        = vm_config.vm.forwarded_ports[ 0 ][ :hostport ]

installer = HomeCooking::Installer.new( host, :port => port )
install.existing_user = { :username => 'user', :password => 'password' }
install.new_user      = { :username => 'me',   :password => 'secret'   }

installer.prepare_system
installer.create_user
installer.install

