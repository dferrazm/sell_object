# SellObject

SellObject is an extensible solution to make it easy exporting ruby objects to be used on price comparison shopping engines. The gem adds helper methods that format your objects making them ready to be consumable by the supported price comparison engines.

Currently, the following shopping engines are supported:

* Shopping UOL (Brazil)

## Installation

Add this line to your application's Gemfile:

    ```ruby
    gem 'sell_object'
    ```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sell_object

## Usage

### Setting up the class

Suppose you have a class named `Product` and want to make its objects sellable through `Shopping UOL`. 
You do that using `sellable_through` as shown below:

```ruby
class Product
	include SellObject

	selling_through :shopping_uol
end
```

Now, to export a given `product` object into a consumable format used in `Shopping UOL`, just call:

```ruby
product.to_shopping_uol
```

In this case, this will generate the XML used by `Shopping UOL` in its search engine, based on the `product` attributes.

### Mapping the attributes

The SellObject comes with a default mapping to be applied through the exporting process. Continuing the `Shopping UOL` example, the mapping is used to grab the `product` attributes and build the XML tags. The default mapping is defined in the following module:

```ruby
module SellObject
	module DefaultMappings
		def self.shopping_uol
			{ 
				codigo: :id, 
				descricao: :description, 
				preco: :price,
				url: :url  
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
				codigo: :code, 
				descricao: :details,
				url: :web_page  
			}
		end
	end	
end
```
In this case, `product` would have to respond to `:code`, `:details` and `:web_page`. Note that we didn't overwrite all the attribute mappings. The leftovers will fall back to the default mapping. So in this example, `product` would still have to respond to the `:price` method.

When defining you own mappings, you can easily unit test them using Test::Unit, Rspec or other testing solutions.

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