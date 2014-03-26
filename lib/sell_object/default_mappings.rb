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
	end
end