require 'spec_helper'

describe SellObject::XmlFormatter do
	describe '#format' do
		let(:target_object) { double some_value: 'some value' }

		before do
			SellObject.stub(:mapping_for).with(target_object, :foo).and_return({some_tag: :some_value})
		end

		it 'formats an object into a xml element based on its mapping, given an engine and a xml root' do
			expect(remove_xml_noise subject.format(target_object, :foo, :xml_root)).to eq remove_xml_noise %q{
				<xml_root>
					<some_tag>some value</some_tag>
				</xml_root>
			}
		end

		context 'passing a formatter proxy' do
			let(:proxy) { double some_tag: 'proxied value' }

			it 'uses the proxy on the format process' do
				expect(remove_xml_noise subject.format(target_object, :foo, :xml_root, proxy)).to eq remove_xml_noise %q{
					<xml_root>
						<some_tag>proxied value</some_tag>
					</xml_root>
				}
			end
		end
	end
end