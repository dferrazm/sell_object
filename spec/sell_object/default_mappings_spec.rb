require 'spec_helper'

describe SellObject::DefaultMappings do
	describe '#shopping_uol' do
		let(:mapping) { subject.shopping_uol }

		it 'maps :codigo to :id' do
			expect(mapping[:codigo]).to eq :id
		end

		it 'maps :descricao to :description' do
			expect(mapping[:descricao]).to eq :description
		end

		it 'maps :preco to :price' do
			expect(mapping[:preco]).to eq :price
		end

		it 'maps :url to :url' do
			expect(mapping[:url]).to eq :url
		end
	end
end