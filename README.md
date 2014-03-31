# SellObject

By [Ima Bold](http://imabold.com).

(Not published yet)

[![Code Climate](https://codeclimate.com/github/imaboldcompany/sell_object.png)](https://codeclimate.com/github/imaboldcompany/sell_object)

SellObject is an extensible solution to make it easy exporting ruby objects to be used on price comparison shopping engines. The gem adds helper methods that format your objects, making them ready to be consumable by the supported price comparison engines.

Currently, the following shopping engines are supported:

* Shopping UOL (Brazil)
* Buscape (Brazil)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sell_object'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sell_object

After you install SellObject and add it to your Gemfile, you need to run the generator:

		$ rails generate sell_object:install

This will add the SellObject initializer into your Rails config/initializers folder.

## Usage

### Setting up the class

Suppose you have a class `Product` and want to make its objects sellable through Shopping UOL. 
You do that by using `sell_through` as shown below:

```ruby
class Product
	include SellObject

	sell_through :shopping_uol
end
```

After that, to export a given `product` object into a consumable format used in Shopping UOL, just call:

```ruby
product.to_shopping_uol
```

In this case, this will generate the XML used by Shopping UOL in its search engine, based on the `product` attributes.

Now, take `products` as collection of `Product` and you want to export all the collection into a consumable format used in Shopping UOL. All you have to do is use the class method passing the `products` collection, as shown:

```ruby
Product.to_shopping_uol products
```

The same approach works for all the other supported shopping engines.

### Mapping the attributes

SellObject comes with a default mapping to be applied through the exporting process. Continuing the Shopping UOL example, the mapping is used to grab the `product` attributes and build the XML tags. The default mapping is defined in the following module:

```ruby
module SellObject
	module DefaultMappings
		def self.shopping_uol
			{ 
				:CODIGO => :id, 
				:DESCRICAO => :description, 
				:PRECO => :price,
				:URL => :url,
				:URL_IMAGEM => :image_url,
				:DEPARTAMENTO => :category  
			}
		end
	end	
end
```
If you want to use the default mapping, just make sure that the object responds to the required methods. In our example, `product` would have to respond to `:id`, `:description`, `:price` and so forth.

If you want to create your own mapping, you can define a module named with the object's class name + 'Mappings'. For our `product` example, we could define like this:

```ruby
module SellObject
	module ProductMappings
		def self.shopping_uol
			{ 
				:CODIGO => :code, 
				:DESCRICAO => :details, 
				:URL => :web_page  
			}
		end
	end	
end
```
In this case, `product` would have to respond to `:code`, `:details` and `:web_page`. Note that we didn't overwrite all the attribute mappings. The leftovers will fall back to the default mapping. So in this example, `product` would still have to respond to the `:price`, `:image_url` and `:category` methods.

When defining you own mappings, you can easily unit test them using Test::Unit, Rspec or other testing solutions.

### Store name

Some shopping engines require a store name to be included in the final output after the exporting process is over. You can define the store name globally in the SellObject initializer, for example:

```ruby
SellObject.setup do |config|
	config.store_name = 'Ima Bold Store'
end
```

If you want to set the store name dynamically, you can pass it to the exporting methods, for example:

```ruby
Product.to_buscape products, 'Ima Bold Store'

product.to_buscape 'Ima Bold Store'
```

If you do not pass the store name neither set it up in the initializer, an error is going to be raised when calling those methods for engines that require a store name.

Here's the list of shopping engines that require a store name for the exporting process:

* Buscape (Brazil)

## Contributing

Questions or problems? Please post them on the [issue tracker](https://github.com/imaboldcompany/sell_object/issues).

You can contribute by doing the following:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

MIT License.