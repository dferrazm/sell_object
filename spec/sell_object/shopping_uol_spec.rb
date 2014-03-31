require 'spec_helper'
include EngineMacros::ShoppingUol

class Product
	include SellObject::ShoppingUol
end

describe SellObject::ShoppingUol do
	it_behaves_like 'shopping_engine', :shopping_uol

	describe '#wrap_xml' do
		it 'inserts the given elements inside the <PRODUTOS> tag' do
			expect(remove_xml_noise subject.wrap_xml('xml elements')).to include '<PRODUTOS>xml elements</PRODUTOS>'
		end
	end
end