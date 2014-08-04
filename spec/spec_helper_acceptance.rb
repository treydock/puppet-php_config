require 'beaker-rspec'

hosts.each do |host|
  # Install Puppet
  install_puppet unless ENV['BEAKER_provision'] == 'no'
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    puppet_module_install(:source => proj_root, :module_name => 'php_config')

    hosts.each do |host|
      if fact('osfamily') == 'RedHat'
        on host, puppet('module', 'install', 'stahnma/epel', '--version', '"0.x"'), { :acceptable_exit_codes => [0,1] }
      end
      on host, puppet('module', 'install', 'puppetlabs-stdlib', '--version', '">=3.2.0 <5.0.0"'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module', 'install', 'puppetlabs-inifile', '--version', '"1.x"'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module', 'install', 'puppetlabs-apache', '--version', '"1.x"'), { :acceptable_exit_codes => [0,1] }
    end
  end
end
