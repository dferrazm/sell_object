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

	describe '#buscape' do
		let(:mapping) { subject.buscape }

		it 'maps :id_oferta to :id' do
			expect(mapping[:id_oferta]).to eq :id
		end

		it 'maps :descricao to :description' do
			expect(mapping[:descricao]).to eq :description
		end

		it 'maps :preco to :price' do
			expect(mapping[:preco]).to eq :price
		end

		it 'maps :link_prod to :url' do
			expect(mapping[:link_prod]).to eq :url
		end

		it 'maps :imagem to :image_url' do
			expect(mapping[:imagem]).to eq :image_url
		end

		it 'maps :categoria to :category' do
			expect(mapping[:categoria]).to eq :category
		end
	end
end