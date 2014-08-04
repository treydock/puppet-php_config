require 'spec_helper_acceptance'

describe 'php_config class' do
  context 'default parameters' do
    it 'should run successfully' do
      pp =<<-EOS
        class { 'php_config':
          php_configs => {
            'Date/date.timezone' => { 'value' => 'America/Chicago' },
          },
        }
      EOS
  
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file('/etc/php.ini') do
      its(:content) { should match /date.timezone = America\/Chicago$/ }
    end
  end
end
