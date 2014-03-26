module SellObject
	module ShoppingUol
		def to_shopping_uol
			#mappings_hash = SellObject.mappings(self).shopping_uol
			mappings_hash = SellObject::DefaultMappings.shopping_uol
			result_xml = SellObject::ShoppingUol::SAMPLE_XML
			mappings_hash.each { |key, value| result_xml.gsub! ":#{key}", send(value).to_s }
			result_xml
		end

		SAMPLE_XML = %q{
			<?xml version="1.0" encoding="iso-8859-1" ?>
			<PRODUTOS>
				<PRODUTO>
					<CODIGO>:codigo</CODIGO>
	  			<DESCRICAO>:descricao</DESCRICAO>
	  			<PRECO>:preco</PRECO>
	  			<URL>:url</URL>
				</PRODUTO>
			</PRODUTOS>
		}
	end
end