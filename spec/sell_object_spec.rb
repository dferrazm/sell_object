require 'spec_helper'

describe SellObject do
	context 'on inclusion' do
		before do
			class TargetClass
				extend SellObject::ClassMethods
			end
		end

		after do
			Object.send :remove_const, :TargetClass
		end

		it 'makes the target class extend SellObject::ClassMethods'	do
			expect(TargetClass.is_a? SellObject::ClassMethods).to be_true
		end

		describe 'ClassMethods' do
			describe '#sell_through' do		
				context 'passing invalid arguments' do
					it 'raises ArgumentError with an invalid engine' do
						expect { TargetClass.sell_through :foo }.to raise_error ArgumentError, 'invalid shopping engine foo'
					end

					it 'raises ArgumentError with a blank arguments' do
						expect { TargetClass.sell_through }.to raise_error ArgumentError, 'must pass at least one shopping engine'
					end
				end

				context 'buscape' do			
					it 'includes the module SellObject::Buscape in the target class' do
						TargetClass.sell_through :buscape
						expect(TargetClass.included_modules).to include SellObject::Buscape				
					end
				end

				context 'shopping_uol' do			
					it 'includes the module SellObject::ShoppingUol in the target class' do
						TargetClass.sell_through :shopping_uol
						expect(TargetClass.included_modules).to include SellObject::ShoppingUol				
					end
				end
			end
		end
	end	

	describe '#supported_engines' do
		it 'returns the supported shopping engines array' do
			expect(subject.supported_engines).to match_array %w(shopping_uol buscape)
		end
	end	

	describe '#mapping_for' do
		before do
			SellObject.stub(:supported_engines).and_return %w(bar)
			SellObject::DefaultMappings.stub(:bar).and_return({t1: :v1, t2: :v2})
			
			class TargetObject
			end
		end

		after do
			Object.send :remove_const, :TargetObject
		end

		it 'raises an error if the given engine is invalid' do
			expect { subject.mapping_for TargetObject.new, :foo }.to raise_error ArgumentError, 'invalid shopping engine foo'
		end

		context 'when there\s no custom mapping defined' do
			it 'returns the default mapping hash for the given object' do
				expect(subject.mapping_for TargetObject.new, :bar).to eq({t1: :v1, t2: :v2})
			end
		end
		
		context 'when there\s a custom mapping defined' do
			before do
				module SellObject::TargetObjectMappings
					def self.bar
						{t2: :v2_custom, t3: :v3}
					end
				end
			end

			after do
				SellObject.send :remove_const, :TargetObjectMappings
			end

			it 'returns the default mapping hash merged with the custom mapping for the given object' do
				expect(subject.mapping_for TargetObject.new, :bar).to eq({t1: :v1, t2: :v2_custom, t3: :v3})
			end
		end
	end
end