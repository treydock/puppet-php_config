require 'spec_helper'

describe 'php_config' do
  include_context :defaults

  let(:facts) { default_facts }

  it { should create_class('php_config') }
  it { should contain_class('php_config::params') }
  it { should contain_class('apache') }
  it { should contain_class('apache::mod::php') }

  it { should have_php_config_resource_count(0) }

  context 'when php_configs is defined' do
    let :params do
      {
        :php_configs => {'Date/date.timezone' => {'value' => 'America/Chicago'}},
      }
    end

    it { should have_php_config_resource_count(1) }
    
    it { should contain_package('php').that_comes_before('Php_config[Date/date.timezone]') }
    it { should contain_php_config('Date/date.timezone').that_notifies('Service[httpd]') }

    it do
      should contain_php_config('Date/date.timezone').with({
        :value  => 'America/Chicago',
      })
    end
  end

  # Test boolean validation
  [
    :notify_apache,
  ].each do |param|
    context "with #{param} => 'foo'" do
      let(:params) {{ param => 'foo' }}
      it { expect { should create_class('php_config') }.to raise_error(Puppet::Error, /is not a boolean/) }
    end
  end

end
