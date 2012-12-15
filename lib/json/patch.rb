module JSON
  class Patch
    def initialize
      @json = nil
    end

    attr_accessor :json

    def test(path, value)
    end

    def remove(path)
    end

    def add(path, value)
    end

    def replace(path, value)
    end

    def move(from, path)
    end

    def copy(from, path)
    end
  end
end

