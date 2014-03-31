require 'rails/generators/base'
require 'securerandom'

module SellObject
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a SellObject initializer."

      def copy_initializer
        template "sell_object.rb", "config/initializers/sell_object.rb"
      end
    end
  end
end