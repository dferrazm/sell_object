module EngineMacros
	module Buscape
		DEFAULT_MAPPING_FIXTURE_ONE = %q{
			<?xml version="1.0" encoding="UTF-8" ?>
			<awesome_store>
				<produtos>
					<produto>
					  <id_oferta>PR1</id_oferta>
					  <descricao>Some lame product</descricao>
					  <preco>10,50</preco>
					  <link_prod>http://example.com/lame-product</link_prod>
					  <imagem>http://example.com/images/lame-product.png</imagem>
					  <categoria>Electronics</categoria>
					</produto>
				</produtos>
			</awesome_store>
		}

		DEFAULT_MAPPING_FIXTURE_MANY = %q{
			<?xml version="1.0" encoding="UTF-8" ?>
			<awesome_store>
				<produtos>
					<produto>
					  <id_oferta>PR1</id_oferta>
					  <descricao>Some lame product</descricao>
					  <preco>10,50</preco>
					  <link_prod>http://example.com/lame-product</link_prod>
					  <imagem>http://example.com/images/lame-product.png</imagem>
					  <categoria>Electronics</categoria>
					</produto>
					<produto>
					  <id_oferta>PR2</id_oferta>
					  <descricao>Some boring product</descricao>
					  <preco>7,00</preco>
					  <link_prod>http://example.com/boring-product</link_prod>
					  <imagem>http://example.com/images/boring-product.png</imagem>
					  <categoria>Kitchenware</categoria>
					</produto>
				</produtos>
			</awesome_store>
		}

		CUSTOM_MAPPING_FIXTURE_MANY = %q{
			<?xml version="1.0" encoding="UTF-8" ?>
			<awesome_store>				
				<produtos>
					<produto>
					  <id_oferta>PR1</id_oferta>
					  <descricao>My custom lame product description</descricao>
					  <preco>10,50</preco>
					  <link_prod>http://example.com/custom-lame-product</link_prod>
					  <imagem>http://example.com/images/lame-product.png</imagem>
					  <categoria>Electronics</categoria>
					</produto>
					<produto>
					  <id_oferta>PR2</id_oferta>
					  <descricao>My custom boring product description</descricao>
					  <preco>7,00</preco>
					  <link_prod>http://example.com/custom-boring-product</link_prod>
					  <imagem>http://example.com/images/boring-product.png</imagem>
					  <categoria>Kitchenware</categoria>
					</produto>
				</produtos>
			</awesome_store>
		}
	end

	module ShoppingUol
		DEFAULT_MAPPING_FIXTURE_ONE = %q{
			<?xml version="1.0" encoding="iso-8859-1" ?>
			<PRODUTOS>
				<PRODUTO>
				  <CODIGO>PR1</CODIGO>
				  <DESCRICAO>Some lame product</DESCRICAO>
				  <PRECO>10.5</PRECO>
				  <URL>http://example.com/lame-product</URL>
				  <URL_IMAGEM>http://example.com/images/lame-product.png</URL_IMAGEM>
				  <DEPARTAMENTO>Electronics</DEPARTAMENTO>
				</PRODUTO>
			</PRODUTOS>
		}

		DEFAULT_MAPPING_FIXTURE_MANY = %q{
			<?xml version="1.0" encoding="iso-8859-1" ?>
			<PRODUTOS>
				<PRODUTO>
				  <CODIGO>PR1</CODIGO>
				  <DESCRICAO>Some lame product</DESCRICAO>
				  <PRECO>10.5</PRECO>
				  <URL>http://example.com/lame-product</URL>
				  <URL_IMAGEM>http://example.com/images/lame-product.png</URL_IMAGEM>
				  <DEPARTAMENTO>Electronics</DEPARTAMENTO>
				</PRODUTO>
				<PRODUTO>
				  <CODIGO>PR2</CODIGO>
				  <DESCRICAO>Some boring product</DESCRICAO>
				  <PRECO>7</PRECO>
				  <URL>http://example.com/boring-product</URL>
				  <URL_IMAGEM>http://example.com/images/boring-product.png</URL_IMAGEM>
				  <DEPARTAMENTO>Kitchenware</DEPARTAMENTO>
				</PRODUTO>
			</PRODUTOS>
		}

		CUSTOM_MAPPING_FIXTURE_MANY = %q{
			<?xml version="1.0" encoding="iso-8859-1" ?>
			<PRODUTOS>
				<PRODUTO>
				  <CODIGO>PR1</CODIGO>
				  <DESCRICAO>My custom lame product description</DESCRICAO>
				  <PRECO>10.5</PRECO>
				  <URL>http://example.com/custom-lame-product</URL>
				  <URL_IMAGEM>http://example.com/images/lame-product.png</URL_IMAGEM>
				  <DEPARTAMENTO>Electronics</DEPARTAMENTO>
				</PRODUTO>
				<PRODUTO>
				  <CODIGO>PR2</CODIGO>
				  <DESCRICAO>My custom boring product description</DESCRICAO>
				  <PRECO>7</PRECO>
				  <URL>http://example.com/custom-boring-product</URL>
				  <URL_IMAGEM>http://example.com/images/boring-product.png</URL_IMAGEM>
				  <DEPARTAMENTO>Kitchenware</DEPARTAMENTO>
				</PRODUTO>
			</PRODUTOS>
		}
	end
end