module SellObject
	module ShoppingUol
		XML_ELEMENT = %q{
					<PRODUTO>
						<CODIGO>:codigo</CODIGO>
		  			<DESCRICAO>:descricao</DESCRICAO>
		  			<PRECO>:preco</PRECO>
		  			<URL>:url</URL>
					</PRODUTO>
		}

		def self.included(base)
	  	base.extend ClassMethods
	  end

	  class FormatterProxy
	  	attr_accessor :target

	  	def initialize(target_object)
	  		self.target = target_object
	  	end

	  	private

	  	def method_missing(method, *args, &block)
	  		target.send(args.first).to_s
	  	end
	  end

	  module ClassMethods
			# Class methods added on inclusion

			def to_shopping_uol(objects)
				elements = objects.map {|obj| obj.to_shopping_uol_element }.join ''
				%Q{
						<?xml version="1.0" encoding="iso-8859-1" ?>
						<PRODUTOS>
							#{elements}
						</PRODUTOS>
					}
			end
		end	 

		# Instance methods added on inclusion

		def to_shopping_uol
			self.class.to_shopping_uol [self]
		end

		def to_shopping_uol_element
			begin				
				custom_mappings_hash = eval "SellObject::#{self.class.name}Mappings.shopping_uol"
			rescue
				custom_mappings_hash = {}
			end	
			default_mappings_hash = SellObject::DefaultMappings.shopping_uol
			result_xml = SellObject::ShoppingUol::XML_ELEMENT.clone
			formatter_proxy = SellObject::ShoppingUol::FormatterProxy.new self
			custom_mappings_hash.each { |key, value| result_xml.gsub! ":#{key}", formatter_proxy.send(key, value) }
			default_mappings_hash.each { |key, value| result_xml.gsub! ":#{key}", formatter_proxy.send(key, value) }
			result_xml
		end
	end
end