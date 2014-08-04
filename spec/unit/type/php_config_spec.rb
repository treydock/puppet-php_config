require 'puppet'
require 'puppet/type/php_config'

describe 'Puppet::Type.type(:php_config)' do
  before :each do
    @php_config = Puppet::Type.type(:php_config).new(:name => 'vars/foo', :value => 'bar')
  end
  it 'should require a name' do
    expect {
      Puppet::Type.type(:php_config).new({})
    }.to raise_error(Puppet::Error, 'Title or name must be provided')
  end
  it 'should not expect a name with whitespace' do
    expect {
      Puppet::Type.type(:php_config).new(:name => 'f oo')
    }.to raise_error(Puppet::Error, /Invalid php_config/)
  end
  it 'should fail when there is no section' do
    expect {
      Puppet::Type.type(:php_config).new(:name => 'foo')
    }.to raise_error(Puppet::Error, /Invalid php_config/)
  end
  it 'should not require a value when ensure is absent' do
    Puppet::Type.type(:php_config).new(:name => 'vars/foo', :ensure => :absent)
  end
  it 'should require a value when ensure is present' do
    expect {
      Puppet::Type.type(:php_config).new(:name => 'vars/foo', :ensure => :present)
    }.to raise_error(Puppet::Error, /Property value must be set/)
  end
  it 'should accept a valid value' do
    @php_config[:value] = 'bar'
    @php_config[:value].should == 'bar'
  end
  it 'should not accept a value with whitespace' do
    @php_config[:value] = 'b ar'
    @php_config[:value].should == 'b ar'
  end
  it 'should accept valid ensure values' do
    @php_config[:ensure] = :present
    @php_config[:ensure].should == :present
    @php_config[:ensure] = :absent
    @php_config[:ensure].should == :absent
  end
  it 'should not accept invalid ensure values' do
    expect {
      @php_config[:ensure] = :latest
    }.to raise_error(Puppet::Error, /Invalid value/)
  end
end
