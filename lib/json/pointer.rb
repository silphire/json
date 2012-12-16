module JSON
  module Pointer
    def self.compile(ptr)
      keys = ptr.split('/')
      keys.map! do |key|
	# escape for JSON
	key.gsub!(%r<\\["\\\/bfnrt]>, {
	  '\\"'  => '"', 
	  '\\\\' => '\\', 
	  '\\/'  => '/', 
	  '\\b'  => 'b', 
	  '\\f'  => 'f', 
	  '\\n'  => 'n', 
	  '\\r'  => 'r', 
	  '\\t'  => 't', 
	})
	
	# escape for JSON Pointer
	key.gsub!('~0', '~')
	key.gsub!('~1', '/')

	key
      end
      keys.shift
      keys.push("") if /\/$/ =~ ptr
      keys
    end

    def self.find(ptr, json)
      return nil if ptr.nil?

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

