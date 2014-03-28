module SellObject
	module Buscape
		XML_ELEMENT = %q{
					<produto>
						<id_oferta>:id_oferta</id_oferta>
		  			<descricao>:descricao</descricao>
		  			<preco>:preco</preco>
		  			<link_prod>:link_prod</link_prod>
		  			<imagem>:imagem</imagem>
		  			<categoria>:categoria</categoria>
					</produto>
		}

		def self.included(base)
	  	base.extend ClassMethods
	  end

	  class FormatterProxy
	  	attr_accessor :target

	  	def initialize(target_object)
	  		self.target = target_object
	  	end

	  	def preco(target_method)
	  		target_value = target.send target_method
	  		raise ArgumentError, "method expects a number, got #{target_value.class.name}: #{target_value}" unless target_value.is_a? Numeric 
	  		('%.2f' % target_value).gsub '.', ','
	  	end

	  	private

	  	def method_missing(method, *args, &block)
	  		target.send args.first
	  	end
	  end

	  module ClassMethods
			# Class methods added on inclusion

			def to_buscape(objects)
				elements = objects.map {|obj| obj.to_buscape_element }.join ''
				%Q{
						<?xml version="1.0" encoding="UTF-8" ?>
						<produtos>
							#{elements}
						</produtos>
					}
			end
		end	 

		# Instance methods added on inclusion

		def to_buscape
			%Q{
					<?xml version="1.0" encoding="UTF-8" ?>
					<produtos>
						#{to_buscape_element}
					</produtos>
				}	
		end

		def to_buscape_element
			begin				
				custom_mappings_hash = eval "SellObject::#{self.class.name}Mappings.buscape"
			rescue
				custom_mappings_hash = {}
			end	
			default_mappings_hash = SellObject::DefaultMappings.buscape
			result_xml = SellObject::Buscape::XML_ELEMENT.clone
			formatter_proxy = SellObject::Buscape::FormatterProxy.new self
			custom_mappings_hash.each { |key, value| result_xml.gsub! ":#{key}", formatter_proxy.send(key, value) }
			default_mappings_hash.each { |key, value| result_xml.gsub! ":#{key}", formatter_proxy.send(key, value) }
			result_xml
		end
	end
end