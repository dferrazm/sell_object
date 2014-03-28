require 'spec_helper'
include EngineMacros::ShoppingUol

describe SellObject::ShoppingUol do
	it_behaves_like 'shopping_engine', :shopping_uol
end