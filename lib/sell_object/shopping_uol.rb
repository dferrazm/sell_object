module SellObject
	module ShoppingUol
		def self.included(base)
	  	base.extend ClassMethods
	  end

	  def self.element_xml
	  	%q{
						<PRODUTO>
							<CODIGO>:codigo</CODIGO>
			  			<DESCRICAO>:descricao</DESCRICAO>
			  			<PRECO>:preco</PRECO>
			  			<URL>:url</URL>
						</PRODUTO>
			}
	  end

	  def self.wrap_xml
	  	%Q{
					<?xml version="1.0" encoding="iso-8859-1" ?>
					<PRODUTOS>
						:elements
					</PRODUTOS>
				}
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
				SellObject::ShoppingUol.wrap_xml.gsub ':elements', elements
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
			result_xml = SellObject::ShoppingUol.element_xml
			formatter_proxy = SellObject::ShoppingUol::FormatterProxy.new self
			custom_mappings_hash.each { |key, value| result_xml.gsub! ":#{key}", formatter_proxy.send(key, value) }
			default_mappings_hash.each { |key, value| result_xml.gsub! ":#{key}", formatter_proxy.send(key, value) }
			result_xml
		end
	end
end