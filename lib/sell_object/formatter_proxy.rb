module SellObject
	class FormatterProxy
  	attr_accessor :target

  	def initialize(target_object)
  		self.target = target_object
  	end

  	private

  	def method_missing(method, *args, &block)
  		target.send(args.first).to_s
  	end
  end
end