require 'spec_helper'

describe SellObject::FormatterProxy do
	let(:target_object) { double description: 'Lorem ipsum' }
	let(:formatter) { SellObject::FormatterProxy.new target_object }

	it 'sets the target object on initialization' do
		expect(formatter.target).to eq target_object
	end

	it 'delegates any method missing to the target method' do
		expect(formatter.foo :description).to eq 'Lorem ipsum'
	end
end