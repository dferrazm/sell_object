require 'spec_helper'

class Product
	include SellObject::ShoppingUol
end

describe SellObject::ShoppingUol do
	let(:lame_product) { Product.new }
	let(:boring_product) { Product.new }
	let(:products) { [lame_product, boring_product] }

	before do
		lame_product.stub(:id).and_return 'PR1'
		lame_product.stub(:description).and_return 'Some lame product'
		lame_product.stub(:price).and_return 10.5
		lame_product.stub(:url).and_return 'http://example.com/lame-product'

		boring_product.stub(:id).and_return 'PR2'
		boring_product.stub(:description).and_return 'Some boring product'
		boring_product.stub(:price).and_return 7
		boring_product.stub(:url).and_return 'http://example.com/boring-product'
	end

	context 'using default mappings' do
		describe 'class methods' do
			describe '#to_shopping_uol' do
				it 'generates the XML accordingly with all the objects attributes' do
					expect(remove_xml_noise Product.to_shopping_uol(products)).to eq remove_xml_noise %q{
						<?xml version="1.0" encoding="iso-8859-1" ?>
						<PRODUTOS>
							<PRODUTO>
							  <CODIGO>PR1</CODIGO>
							  <DESCRICAO>Some lame product</DESCRICAO>
							  <PRECO>10.5</PRECO>
							  <URL>http://example.com/lame-product</URL>
							</PRODUTO>
							<PRODUTO>
							  <CODIGO>PR2</CODIGO>
							  <DESCRICAO>Some boring product</DESCRICAO>
							  <PRECO>7</PRECO>
							  <URL>http://example.com/boring-product</URL>
							</PRODUTO>
						</PRODUTOS>
					}
				end
			end
		end

		describe 'instance methods' do
			it 'generates the XML accordingly with the object attributes' do
				expect(remove_xml_noise lame_product.to_shopping_uol).to eq remove_xml_noise %q{
					<?xml version="1.0" encoding="iso-8859-1" ?>
					<PRODUTOS>
						<PRODUTO>
						  <CODIGO>PR1</CODIGO>
						  <DESCRICAO>Some lame product</DESCRICAO>
						  <PRECO>10.5</PRECO>
						  <URL>http://example.com/lame-product</URL>
						</PRODUTO>
					</PRODUTOS>
				}
			end
		end	
	end

	context 'using custom mappings' do
		before do
			lame_product.stub(:custom_description).and_return 'My custom lame product description'
			lame_product.stub(:custom_url).and_return 'http://example.com/custom-lame-product'

			module SellObject::ProductMappings
				def self.shopping_uol
					{ descricao: :custom_description,  url: :custom_url }
				end
			end	
		end

		describe 'class methods' do
			describe '#to_shopping_uol' do
				before do
					boring_product.stub(:custom_description).and_return 'My custom boring product description'
					boring_product.stub(:custom_url).and_return 'http://example.com/custom-boring-product'
				end

				it 'generates the XML accordingly with all the objects attributes and the custom mappings' do
					expect(remove_xml_noise Product.to_shopping_uol(products)).to eq remove_xml_noise %q{
						<?xml version="1.0" encoding="iso-8859-1" ?>
						<PRODUTOS>
							<PRODUTO>
							  <CODIGO>PR1</CODIGO>
							  <DESCRICAO>My custom lame product description</DESCRICAO>
							  <PRECO>10.5</PRECO>
							  <URL>http://example.com/custom-lame-product</URL>
							</PRODUTO>
							<PRODUTO>
							  <CODIGO>PR2</CODIGO>
							  <DESCRICAO>My custom boring product description</DESCRICAO>
							  <PRECO>7</PRECO>
							  <URL>http://example.com/custom-boring-product</URL>
							</PRODUTO>
						</PRODUTOS>
					}
				end
			end
		end

		describe 'instance methods' do
			describe '#to_shopping_uol' do
				it 'generates the XML accordingly with the object attributes defined in the custom mappings' do
					expect(remove_xml_noise lame_product.to_shopping_uol).to eq remove_xml_noise %q{
						<?xml version="1.0" encoding="iso-8859-1" ?>
						<PRODUTOS>
							<PRODUTO>
							  <CODIGO>PR1</CODIGO>
							  <DESCRICAO>My custom lame product description</DESCRICAO>
							  <PRECO>10.5</PRECO>
							  <URL>http://example.com/custom-lame-product</URL>
							</PRODUTO>
						</PRODUTOS>
					} 	
				end
			end
		end
	end
end

def remove_xml_noise(xml)
	xml.gsub("\n",'').gsub("\t",'').gsub />[ \t]+</, '><'
end