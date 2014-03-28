module SpecMacros
	def remove_xml_noise(xml)
		xml.gsub("\n",'').gsub("\t",'').gsub />[ \t]+</, '><'
	end
end