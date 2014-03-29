require 'spec_helper'
include EngineMacros::Buscape

describe SellObject::Buscape do
	it_behaves_like 'shopping_engine', :buscape

	describe '#wrap_xml' do
		it 'inserts the timestamp into the xml' do
			timestamp = Time.now.to_s
			subject.stub(:timestamp).and_return '2014-03-29 13:28:32 -0300'
			expect(subject.wrap_xml).to include '<!-- 2014-03-29 13:28:32 -0300 -->'
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