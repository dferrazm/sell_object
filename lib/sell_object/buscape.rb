module SellObject
	module Buscape
		def self.included(base)
	  	base.extend ClassMethods
	  end

	  def self.wrap_xml(elements)
	  	%Q{
					<?xml version="1.0" encoding="UTF-8" ?>
					<!-- #{timestamp} -->
					<produtos>
						#{elements}
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
				elements = objects.map {|obj| SellObject::XmlFormatter.format obj, :buscape, :produto, SellObject::Buscape::FormatterProxy.new(obj) }.join ''
				SellObject::Buscape.wrap_xml elements
			end
		end	 

		# Instance methods added on inclusion

		def to_buscape
			self.class.to_buscape [self]
		end
	end
end