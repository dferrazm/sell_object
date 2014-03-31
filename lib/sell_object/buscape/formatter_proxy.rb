module SellObject
	module Buscape
		class FormatterProxy < SellObject::FormatterProxy
	  	def preco(target_method)
	  		target_value = target.send target_method
	  		raise ArgumentError, "method expects a number, got #{target_value.class.name}: #{target_value}" unless target_value.is_a? Numeric 
	  		('%.2f' % target_value).gsub '.', ','
	  	end
	  end
	end
end