require 'spec_helper'

class Product
	include SellObject::ShoppingUol
end

describe SellObject::ShoppingUol do
	describe '#to_shopping_uol' do
		let(:some_product) { Product.new }

		before do
			some_product.stub(:id).and_return 'PR1'
			some_product.stub(:description).and_return 'Some lame product'
			some_product.stub(:price).and_return 10.5
			some_product.stub(:url).and_return 'http://example.com/default-product'
		end

		context 'using the default mappings' do
			it 'generates the XML accordingly with the object attributes' do
				expect(remove_xml_noise some_product.to_shopping_uol).to eq remove_xml_noise %q{
					<?xml version="1.0" encoding="iso-8859-1" ?>
					<PRODUTOS>
						<PRODUTO>
						  <CODIGO>PR1</CODIGO>
						  <DESCRICAO>Some lame product</DESCRICAO>
						  <PRECO>10.5</PRECO>
						  <URL>http://example.com/default-product</URL>
						</PRODUTO>
					</PRODUTOS>
				}
			end
		end

		context 'using custom mappings'	do						
			before do
				some_product.stub(:custom_description).and_return 'My custom lame product description'
				some_product.stub(:custom_url).and_return 'http://example.com/custom-product'

				module SellObject::ProductMappings
					def self.shopping_uol
						{ descricao: :custom_description,  url: :custom_url }
					end
				end
			end

			it 'generates the XML accordingly with the object attributes defined in the custom mappings' do
				expect(remove_xml_noise some_product.to_shopping_uol).to eq remove_xml_noise %q{
					<?xml version="1.0" encoding="iso-8859-1" ?>
					<PRODUTOS>
						<PRODUTO>
						  <CODIGO>PR1</CODIGO>
						  <DESCRICAO>My custom lame product description</DESCRICAO>
						  <PRECO>10.5</PRECO>
						  <URL>http://example.com/custom-product</URL>
						</PRODUTO>
					</PRODUTOS>
				} 	
			end
		end	
	end
end

def remove_xml_noise(xml)
	xml.gsub("\n",'').gsub("\t",'').gsub />[ \t]+</, '><'
end