require 'spec_helper'
describe 'openresty' do

  context 'with defaults for all parameters' do
    it { should contain_class('openresty') }
  end
end
