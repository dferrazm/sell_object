# Use this hook to configure SellObject settings
SellObject.setup do |config|
	# Set up the store name to be used on engines that wrap up their outputs under this single name.
	config.store_name = '<%= Rails.application.class.parent_name %>'
end