require 'nokogiri'

require 'sell_object/version'
require 'sell_object/default_mappings'
require 'sell_object/xml_formatter'
require 'sell_object/formatter_proxy'
require 'sell_object/buscape/formatter_proxy'
require 'sell_object/shopping_uol'
require 'sell_object/buscape'

module SellObject
  def self.included(base)
  	base.extend ClassMethods
  end  

  def self.setup
    yield SellObject::Config
  end

  def self.supported_engines
  	%w(shopping_uol buscape)
  end

  def self.validate_engine(engine)
    raise ArgumentError.new("invalid shopping engine #{engine}") unless supported_engines.include? engine.to_s
  end
  
  def self.mapping_for(obj, engine)
    validate_engine engine
    begin       
      custom_mappings_hash = eval "SellObject::#{obj.class.name}Mappings.#{engine}"
    rescue
      custom_mappings_hash = {}
    end 
    default_mappings_hash = SellObject::DefaultMappings.send engine
    default_mappings_hash.merge custom_mappings_hash
  end

  module ClassMethods
  	def sell_through(*engines)
  		raise ArgumentError.new('must pass at least one shopping engine') if engines.empty?
  		engines.each do |engine|
  			SellObject.validate_engine engine
				camelized_engine = engine.to_s.split('_').map {|w| w.capitalize}.join
  			include eval("SellObject::#{camelized_engine}")
  		end
  	end
  end

  module Config
    @@store_name = nil

    def self.store_name
      @@store_name
    end

    def self.store_name=(name)
      @@store_name = name
    end
  end
end
