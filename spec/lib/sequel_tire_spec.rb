require File.expand_path('../spec_helper', File.dirname(__FILE__))

describe 'something' do
  let(:model) { TireSampleModel.new }

  it 'test' do
    TireSampleModel.tire_test.should eq 'just a test'
  end

  it 'sample' do
    model.tire_sample.should eq 'just a sample'
  end

  it 'search' do
    TireSampleModel.search
  end
end