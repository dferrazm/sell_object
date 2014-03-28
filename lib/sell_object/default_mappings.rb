module SellObject
	module DefaultMappings
		def self.shopping_uol
			{
				codigo: :id, 
				descricao: :description, 
				preco: :price,
				url: :url
			}
		end

		def self.buscape
			{
				id_oferta: :id, 
				descricao: :description, 
				preco: :price,
				link_prod: :url,
				imagem: :image_url,
				categoria: :category
			}
		end
	end
end