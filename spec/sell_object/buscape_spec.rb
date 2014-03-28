require 'spec_helper'
include EngineMacros::Buscape

describe SellObject::Buscape do
	it_behaves_like 'shopping_engine', :buscape
end