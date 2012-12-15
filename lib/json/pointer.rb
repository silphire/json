module JSON
  module Pointer
    def self.compile(ptr)
      keys = ptr.split('/')
      keys.map! do |key|
	key.gsub!('~0', '~')
	key.gsub!('~1', '/')
	key
      end
      keys
    end

    def self.find(ptr, json)
      keys = self.compile(ptr)
      keys.each do |key|
	if json.kind_of?(Array)
	  if /^\d+$/ =~ key
	    json = json[key.to_i]
	  else
	    return nil
	  end
	elsif json.kind_of?(Hash)
	  json = json[key]
	else
	  return nil
	end
      end
      return json
    end
  end
end

