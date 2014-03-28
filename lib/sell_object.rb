require 'sell_object/version'
require 'sell_object/default_mappings'
require 'sell_object/shopping_uol'

module SellObject
  def self.included(base)
  	base.extend ClassMethods
  end  

  def self.supported_engines
  	%w(shopping_uol)
  end

  module ClassMethods
  	def sell_through(*engines)
  		raise ArgumentError.new('must pass at least one shopping engine') if engines.empty?
  		engines.each do |engine|
  			raise ArgumentError.new("invalid shopping engine #{engine}") unless SellObject.supported_engines.include? engine.to_s
				camelized_engine = engine.to_s.split('_').map {|w| w.capitalize}.join
  			include eval("SellObject::#{camelized_engine}")
  		end
  	end
  end
end
