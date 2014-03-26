require 'spec_helper'

describe SellObject::ShoppingUol do
	describe '#to_shopping_uol' do
		context 'using the default mappings' do
			class Product
				include SellObject::ShoppingUol
				
				def id
					'PR1'
				end

				def description
					'Some lame product'
				end

				def price
					10.5
				end

				def url
					'http://example.com/default-product'
				end
			end

			let(:default_product) { Product.new }

			it 'generates the XML accordingly with the object attributes' do
				result_xml = remove_xml_noise default_product.to_shopping_uol
				expected_xml = remove_xml_noise IO.read('./spec/support/shopping_uol/from_default_mappings.xml')
				expect(result_xml).to eq expected_xml
			end
		end

		context 'using custom mappings'		
	end
end

def remove_xml_noise(xml)
	xml.gsub("\n",'').gsub("\t",'').gsub />[ \t]+</, '><'
end