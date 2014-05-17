class Route
  attr_accessor :method, :path, :path_regex, :block

  def initialize(method, path, block)
    @method = method
    @path = path
    @path_regex = Regexp.new('\A' + path.split('/').map { |part|
      if part.start_with?(':')
        '([^/]+)'
      else
        part
      end
    }.join('/') + '/?\z')
    @block = block
  end

  def match(method, path)
    self.method == method && path_regex.match(path)
  end

  def call(path)
    args = path_regex.match(path).captures
    block.call(*args)
  end
end

@routes = []

def get(path, &block)
  @routes << Route.new('get', path, block)
end

def match(request)
  method, path = request.split(' ')[0,2]
  method.downcase!
  puts @routes.find { |route| route.match(method, path) }.call(path)
end
