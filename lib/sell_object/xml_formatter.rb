module SellObject
	module XmlFormatter
		def self.format(obj, engine, xml_root, formatter_proxy = nil)
	    mapping = SellObject.mapping_for obj, engine
	    formatter_proxy ||= SellObject::FormatterProxy.new obj
	    xml_builder = Nokogiri::XML::Builder.new do |xml|
	    	xml.send xml_root do
	    		mapping.each do |tag, mapped_method|
	    			xml.send tag, formatter_proxy.send(tag, mapped_method)
	    		end
	    	end
	    end
	    xml_builder.doc.root.to_xml
	  end
	end
end