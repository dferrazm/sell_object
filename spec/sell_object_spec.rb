require 'spec_helper'

class TargetClass
	extend SellObject::ClassMethods
end

describe SellObject do
	context 'on inclusion' do
		it 'makes the target class extend SellObject::ClassMethods'	do
			expect(TargetClass.is_a? SellObject::ClassMethods).to be_true
		end
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

			context 'shopping_uol' do			
				it 'includes the module SellObject::ShoppingUol in the target class' do
					TargetClass.sell_through :shopping_uol
					expect(TargetClass.included_modules).to include SellObject::ShoppingUol				
				end
			end
		end
	end

	describe '#supported_engines' do
		it 'returns the supported shopping engines array' do
			expect(subject.supported_engines).to match_array %w(shopping_uol)
		end
	end	
end