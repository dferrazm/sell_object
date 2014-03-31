shared_examples_for 'shopping_engine' do |engine|
	camelized_engine = engine.to_s.split('_').map {|w| w.capitalize}.join

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

		SellObject::Config.stub(:store_name).and_return 'awesome_store'
	end

	describe 'class_methods' do
		describe "#to_#{engine}" do
			context 'using default mappings' do
				it 'generates the XML accordingly with all the objects attributes' do
					expect(remove_xml_noise Product.send("to_#{engine}", products)).to eq remove_xml_noise macros::DEFAULT_MAPPING_FIXTURE_MANY
				end
			end

			context 'using custom mappings' do
				before do
					lame_product.stub(:custom_description).and_return 'My custom lame product description'
					lame_product.stub(:custom_url).and_return 'http://example.com/custom-lame-product'
					boring_product.stub(:custom_description).and_return 'My custom boring product description'
					boring_product.stub(:custom_url).and_return 'http://example.com/custom-boring-product'

					module SellObject::ProductMappings
		 				def self.buscape
		 					{ :descricao => :custom_description,  :link_prod => :custom_url }
		 				end

		 				def self.shopping_uol
			 				{ :DESCRICAO => :custom_description,  :URL => :custom_url }
			 			end
			 		end		
				end

				after do
					SellObject.send :remove_const, :ProductMappings
				end

				it 'generates the XML accordingly with all the objects attributes and the custom mappings' do
					expect(remove_xml_noise Product.send("to_#{engine}", products)).to eq remove_xml_noise macros::CUSTOM_MAPPING_FIXTURE_MANY
				end
			end			
		end
	end

	describe 'instance methods' do
		describe "#to_#{engine}" do
			it 'generates the XML accordingly with the object attributes' do
				expect(remove_xml_noise lame_product.send("to_#{engine}")).to eq remove_xml_noise macros::DEFAULT_MAPPING_FIXTURE_ONE
			end

			# it "calls the #to_#{engine} class method passing the instance wrapped in an array" do
			# 	Product.should_receive(:"to_#{engine}").with [lame_product]
			# 	lame_product.send "to_#{engine}"
			# end
		end			
	end
end