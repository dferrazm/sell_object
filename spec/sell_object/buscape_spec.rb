require 'spec_helper'

class Product
	include SellObject::Buscape
end

describe SellObject::Buscape do
	let(:lame_product) { Product.new }
	let(:boring_product) { Product.new }
	let(:products) { [lame_product, boring_product] }

	before do
		lame_product.stub(:id).and_return 'PR1'
		lame_product.stub(:description).and_return 'Some lame product'
		lame_product.stub(:price).and_return 10.5
		lame_product.stub(:category).and_return 'Electronics'
		lame_product.stub(:url).and_return 'http://example.com/lame-product'
		lame_product.stub(:image_url).and_return 'http://example.com/images/lame-product.png'

		boring_product.stub(:id).and_return 'PR2'
		boring_product.stub(:description).and_return 'Some boring product'
		boring_product.stub(:price).and_return 7
		boring_product.stub(:category).and_return 'Kitchenware'
		boring_product.stub(:url).and_return 'http://example.com/boring-product'
		boring_product.stub(:image_url).and_return 'http://example.com/images/boring-product.png'
	end

	context 'using default mappings' do
		describe 'class methods' do
			describe '#to_buscape' do
				it 'generates the XML accordingly with all the objects attributes' do
					expect(remove_xml_noise Product.to_buscape(products)).to eq remove_xml_noise %q{
						<?xml version="1.0" encoding="UTF-8" ?>
						<produtos>
							<produto>
							  <id_oferta>PR1</id_oferta>
							  <descricao>Some lame product</descricao>
							  <preco>10,50</preco>
							  <link_prod>http://example.com/lame-product</link_prod>
							  <imagem>http://example.com/images/lame-product.png</imagem>
							  <categoria>Electronics</categoria>
							</produto>
							<produto>
							  <id_oferta>PR2</id_oferta>
							  <descricao>Some boring product</descricao>
							  <preco>7,00</preco>
							  <link_prod>http://example.com/boring-product</link_prod>
							  <imagem>http://example.com/images/boring-product.png</imagem>
							  <categoria>Kitchenware</categoria>
							</produto>
						</produtos>
					}
				end
			end
		end

		describe 'instance methods' do
			it 'generates the XML accordingly with the object attributes' do
				expect(remove_xml_noise lame_product.to_buscape).to eq remove_xml_noise %q{
					<?xml version="1.0" encoding="UTF-8" ?>
					<produtos>
						<produto>
						  <id_oferta>PR1</id_oferta>
						  <descricao>Some lame product</descricao>
						  <preco>10,50</preco>
						  <link_prod>http://example.com/lame-product</link_prod>
						  <imagem>http://example.com/images/lame-product.png</imagem>
						  <categoria>Electronics</categoria>
						</produto>
					</produtos>
				}
			end
		end	
	end

	context 'using custom mappings' do
		before do
			lame_product.stub(:custom_description).and_return 'My custom lame product description'
			lame_product.stub(:custom_url).and_return 'http://example.com/custom-lame-product'

			module SellObject::ProductMappings
				def self.buscape
					{ descricao: :custom_description,  link_prod: :custom_url }
				end
			end	
		end

		describe 'class methods' do
			describe '#to_buscape' do
				before do
					boring_product.stub(:custom_description).and_return 'My custom boring product description'
					boring_product.stub(:custom_url).and_return 'http://example.com/custom-boring-product'
				end

				it 'generates the XML accordingly with all the objects attributes and the custom mappings' do
					expect(remove_xml_noise Product.to_buscape(products)).to eq remove_xml_noise %q{
						<?xml version="1.0" encoding="UTF-8" ?>
						<produtos>
							<produto>
							  <id_oferta>PR1</id_oferta>
							  <descricao>My custom lame product description</descricao>
							  <preco>10,50</preco>
							  <link_prod>http://example.com/custom-lame-product</link_prod>
							  <imagem>http://example.com/images/lame-product.png</imagem>
							  <categoria>Electronics</categoria>
							</produto>
							<produto>
							  <id_oferta>PR2</id_oferta>
							  <descricao>My custom boring product description</descricao>
							  <preco>7,00</preco>
							  <link_prod>http://example.com/custom-boring-product</link_prod>
							  <imagem>http://example.com/images/boring-product.png</imagem>
							  <categoria>Kitchenware</categoria>
							</produto>
						</produtos>
					}
				end
			end
		end

		describe 'instance methods' do
			describe '#to_buscape' do
				it 'generates the XML accordingly with the object attributes defined in the custom mappings' do
					expect(remove_xml_noise lame_product.to_buscape).to eq remove_xml_noise %q{
						<?xml version="1.0" encoding="UTF-8" ?>
						<produtos>
							<produto>
							  <id_oferta>PR1</id_oferta>
							  <descricao>My custom lame product description</descricao>
							  <preco>10,50</preco>
							  <link_prod>http://example.com/custom-lame-product</link_prod>
							  <imagem>http://example.com/images/lame-product.png</imagem>
							  <categoria>Electronics</categoria>
							</produto>
						</produtos>
					} 	
				end
			end
		end
	end
end

def remove_xml_noise(xml)
	xml.gsub("\n",'').gsub("\t",'').gsub />[ \t]+</, '><'
end