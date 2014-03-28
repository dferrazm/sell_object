shared_examples_for 'shopping_engine' do |engine|
	camelized_engine = engine.to_s.split('_').map {|w| w.capitalize}.join
	class Product
	end
	Product.send :include, eval("SellObject::#{camelized_engine}")

	let(:macros) { eval("EngineMacros::#{camelized_engine}") }
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
			describe "#to_#{engine}" do
				it 'generates the XML accordingly with all the objects attributes' do
					expect(remove_xml_noise Product.send("to_#{engine}", products)).to eq remove_xml_noise macros::DEFAULT_MAPPING_FIXTURE_MANY
				end
			end
		end

		describe 'instance methods' do
			it 'generates the XML accordingly with the object attributes' do
				expect(remove_xml_noise lame_product.send("to_#{engine}")).to eq remove_xml_noise macros::DEFAULT_MAPPING_FIXTURE_ONE
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

 				def self.shopping_uol
	 				{ descricao: :custom_description,  url: :custom_url }
	 			end
	 		end		
		end

		after do
			SellObject.send :remove_const, :ProductMappings
		end

		describe 'class methods' do
			describe "#to_#{engine}" do
				before do
					boring_product.stub(:custom_description).and_return 'My custom boring product description'
					boring_product.stub(:custom_url).and_return 'http://example.com/custom-boring-product'
				end

				it 'generates the XML accordingly with all the objects attributes and the custom mappings' do
					expect(remove_xml_noise Product.send("to_#{engine}", products)).to eq remove_xml_noise macros::CUSTOM_MAPPING_FIXTURE_MANY
				end
			end
		end

		describe 'instance methods' do
			describe "#to_#{engine}" do
				it 'generates the XML accordingly with the object attributes defined in the custom mappings' do
					expect(remove_xml_noise lame_product.send("to_#{engine}")).to eq remove_xml_noise macros::CUSTOM_MAPPING_FIXTURE_ONE	
				end
			end
		end
	end
end