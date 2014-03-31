require 'spec_helper'

describe SellObject::Buscape::FormatterProxy do
	let(:target_object) { double price: 10.5, description: 'Lorem ipsum' }
	let(:formatter) { SellObject::Buscape::FormatterProxy.new target_object }

	it 'extends from SellObject::FormatterProxy' do
		expect(formatter.is_a? SellObject::FormatterProxy).to be_true
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