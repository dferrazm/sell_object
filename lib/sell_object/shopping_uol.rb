module SellObject
	module ShoppingUol
		def self.included(base)
	  	base.extend ClassMethods
	  end

	  def self.wrap_xml(elements)
	  	result = Nokogiri::XML::Builder.new(encoding: 'iso-8859-1') do |xml|
	  		xml.PRODUTOS {
  				xml << elements
	  		}
	  	end
	  	result.to_xml
	  end
	  	  
	  module ClassMethods
			# Class methods added on inclusion

			def to_shopping_uol(objects)
				elements = objects.map {|obj| SellObject::XmlFormatter.format obj, :shopping_uol, :PRODUTO }.join ''
				SellObject::ShoppingUol.wrap_xml elements
			end
		end	 

		# Instance methods added on inclusion

		def to_shopping_uol
			self.class.to_shopping_uol [self]
		end
	end
end