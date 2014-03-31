module SellObject
	module DefaultMappings
		def self.shopping_uol
			{
				:CODIGO => :id, 
				:DESCRICAO => :description, 
				:PRECO => :price,
				:URL => :url,
				:URL_IMAGEM => :image_url,
				:DEPARTAMENTO => :category
			}
		end

		def self.buscape
			{
				:id_oferta => :id, 
				:descricao => :description, 
				:preco => :price,
				:link_prod => :url,
				:imagem => :image_url,
				:categoria => :category
			}
		end
	end
end