module SellObject
	module Buscape
		def self.included(base)
	  	base.extend ClassMethods
	  end

	  def self.wrap_xml
	  	%Q{
					<?xml version="1.0" encoding="UTF-8" ?>
					<!-- #{timestamp} -->
					<produtos>
						:elements
					</produtos>
				}
	  end

	  def self.timestamp
	  	now = Time.now
    	zone_diff = now.strftime("%z").to_i / 100
    	time = now.strftime "%Y-%m-%dT%H:%M:%SGMT#{'+' if zone_diff >= 0}#{zone_diff}"
	  	"Generated at #{time}"
	  end	  

	  module ClassMethods
			# Class methods added on inclusion

			def to_buscape(objects)
				elements = objects.map {|obj| obj.to_buscape_element }.join ''
				SellObject::Buscape.wrap_xml.gsub ':elements', elements				
			end
		end	 

		# Instance methods added on inclusion

		def to_buscape
			self.class.to_buscape [self]
		end

		def to_buscape_element
			proxy = SellObject::Buscape::FormatterProxy.new self
			SellObject::XmlFormatter.format self, :buscape, :produto, proxy
		end
	end
end