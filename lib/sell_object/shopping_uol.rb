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
			%Q{
					<?xml version="1.0" encoding="iso-8859-1" ?>
					<PRODUTOS>
						#{to_shopping_uol_element}
					</PRODUTOS>
				}	
		end

		def to_shopping_uol_element
			begin				
				custom_mappings_hash = eval "SellObject::#{self.class.name}Mappings.shopping_uol"
			rescue
				custom_mappings_hash = {}
			end	
			default_mappings_hash = SellObject::DefaultMappings.shopping_uol
			result_xml = SellObject::ShoppingUol::XML_ELEMENT.clone
			custom_mappings_hash.each { |key, value| result_xml.gsub! ":#{key}", send(value).to_s }
			default_mappings_hash.each { |key, value| result_xml.gsub! ":#{key}", send(value).to_s }
			result_xml
		end
	end
end