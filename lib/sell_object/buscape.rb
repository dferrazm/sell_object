module SellObject
	module Buscape
		def self.included(base)
	  	base.extend ClassMethods
	  end

	  def self.wrap_xml(elements, store_name = nil)
	  	store_name ||= SellObject::Config.store_name
	  	raise ArgumentError, 'No store name found (nil). You have to either pass it as an argument or set it up in SellObject::Config' if store_name.nil?
	  	%Q{
					<?xml version="1.0" encoding="UTF-8" ?>
					<!-- #{timestamp} -->
					<#{store_name}>
						<produtos>
							#{elements}
						</produtos>
					</#{store_name}>
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

			def to_buscape(objects, store_name = nil)
				elements = objects.map {|obj| SellObject::XmlFormatter.format obj, :buscape, :produto, SellObject::Buscape::FormatterProxy.new(obj) }.join ''
				SellObject::Buscape.wrap_xml elements, store_name
			end
		end	 

		# Instance methods added on inclusion

		def to_buscape(store_name = nil)
			self.class.to_buscape [self], store_name
		end
	end
end