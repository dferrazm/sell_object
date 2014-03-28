require 'spec_helper'

describe SellObject::Buscape::FormatterProxy do
	let(:target_object) { double price: 10.5, description: 'Lorem ipsum' }
	let(:formatter) { SellObject::Buscape::FormatterProxy.new target_object }

	it 'sets the target object on initialization' do
		expect(formatter.target).to eq target_object
	end

	it 'delegates any method missing to the target method' do
		expect(formatter.foo :description).to eq 'Lorem ipsum'
	end

	describe '#preco' do
		it 'formats the value from the target object to include two decimal cases with comma as sepparator' do
			expect(formatter.preco :price).to eq '10,50'
		end

		it 'returns an error when the value from the target object is not a number' do
			expect { formatter.preco :description }.to raise_error ArgumentError, 'method expects a number, got String: Lorem ipsum'
		end
	end
end