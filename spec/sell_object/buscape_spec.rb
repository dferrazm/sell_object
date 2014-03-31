require 'spec_helper'
include EngineMacros::Buscape

class Product
	include SellObject::Buscape
end

describe SellObject::Buscape do
	it_behaves_like 'shopping_engine', :buscape

	context 'still behaving as shopping_engine' do
		let(:product) { Product.new }

		before do
			SellObject::XmlFormatter.stub(:format).and_return 'xml element'
		end

		describe 'class_methods' do
			describe "to_buscape" do
				context 'passing the store name' do
					it 'generates the XML with the given store name as root' do
						expect(remove_xml_noise Product.to_buscape([product], 'great')).to match /<great><produtos>.*<\/produtos><\/great>/
					end
				end
			end
		end

		describe 'instance methods' do
			describe "to_buscape" do
				context 'passing the store name' do
					it 'generates the XML with the given store name as root' do
						expect(remove_xml_noise product.to_buscape('great')).to match /<great><produtos>.*<\/produtos><\/great>/
					end
				end
			end			
		end
	end	

	describe '#wrap_xml' do
		before do
			SellObject::Config.stub(:store_name).and_return 'awesome'
		end

		it 'inserts the timestamp into the xml' do
			timestamp = Time.now.to_s
			subject.stub(:timestamp).and_return '2014-03-29 13:28:32 -0300'
			expect(subject.wrap_xml 'xml elements').to include '<!--2014-03-29 13:28:32 -0300-->'
		end

		it 'inserts the given elements inside the <produtos> tag' do
			expect(remove_xml_noise subject.wrap_xml('xml elements')).to include '<produtos>xml elements</produtos>'			
		end

		it 'wraps the <produtos> tag with the store name set up in config' do
			SellObject::Config.stub(:store_name).and_return 'awesome'
			expect(remove_xml_noise subject.wrap_xml('elements')).to match /<awesome><produtos>.*<\/produtos><\/awesome>/
		end		

		it 'raises an error if theres no store name set up' do
			SellObject::Config.stub(:store_name).and_return nil
			expect { subject.wrap_xml 'elements' }.to raise_error ArgumentError, 'No store name found (nil). You have to either pass it as an argument or set it up in SellObject::Config'
		end

		context 'when passing the store name as an argument' do
			it 'wraps the <produtos> tag with the given store name' do
				expect(remove_xml_noise subject.wrap_xml('elements', 'boring')).to match /<boring><produtos>.*<\/produtos><\/boring>/
			end		
		end
	end

	describe '#timestamp' do
		it 'returns the time now correctly formatted' do
			Time.stub(:now).and_return Time.new(2014,3,28,10,42,48,'-03:00')
			expect(subject.timestamp).to eq 'Generated at 2014-03-28T10:42:48GMT-3'
			Time.stub(:now).and_return Time.new(2011,1,4,17,22,58,'+01:00')
			expect(subject.timestamp).to eq 'Generated at 2011-01-04T17:22:58GMT+1'
			Time.stub(:now).and_return Time.new(2011,1,4,17,22,58,'+00:00')
			expect(subject.timestamp).to eq 'Generated at 2011-01-04T17:22:58GMT+0'
		end
	end
end