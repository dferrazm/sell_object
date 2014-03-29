module SellObject
	module Buscape
		def self.included(base)
	  	base.extend ClassMethods
	  end

	  def self.element_xml
	  	%q{
						<produto>
							<id_oferta>:id_oferta</id_oferta>
			  			<descricao>:descricao</descricao>
			  			<preco>:preco</preco>
			  			<link_prod>:link_prod</link_prod>
			  			<imagem>:imagem</imagem>
			  			<categoria>:categoria</categoria>
						</produto>
			}	
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

	  class FormatterProxy
	  	attr_accessor :target

	  	def initialize(target_object)
	  		self.target = target_object
	  	end

	  	def preco(target_method)
	  		target_value = target.send target_method
	  		raise ArgumentError, "method expects a number, got #{target_value.class.name}: #{target_value}" unless target_value.is_a? Numeric 
	  		('%.2f' % target_value).gsub '.', ','
	  	end

	  	private

	  	def method_missing(method, *args, &block)
	  		target.send(args.first).to_s
	  	end
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
			begin				
				custom_mappings_hash = eval "SellObject::#{self.class.name}Mappings.buscape"
			rescue
				custom_mappings_hash = {}
			end	
			default_mappings_hash = SellObject::DefaultMappings.buscape
			result_xml = SellObject::Buscape.element_xml
			formatter_proxy = SellObject::Buscape::FormatterProxy.new self
			custom_mappings_hash.each { |key, value| result_xml.gsub! ":#{key}", formatter_proxy.send(key, value) }
			default_mappings_hash.each { |key, value| result_xml.gsub! ":#{key}", formatter_proxy.send(key, value) }
			result_xml
		end
	end
end