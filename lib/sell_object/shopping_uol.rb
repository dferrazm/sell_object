module SellObject
	module ShoppingUol
		def self.included(base)
	  	base.extend ClassMethods
	  end

	  def self.wrap_xml
	  	%Q{
					<?xml version="1.0" encoding="iso-8859-1" ?>
					<PRODUTOS>
						:elements
					</PRODUTOS>
				}
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
			SellObject::XmlFormatter.format self, :shopping_uol, :PRODUTO
		end
	end
end