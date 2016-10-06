require 'spec_helper'
describe 'pdsh' do

  context 'with default values for all parameters' do
    it { should contain_class('pdsh') }
  end
end
