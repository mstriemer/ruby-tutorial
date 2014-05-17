class Route
  attr_accessor :method, :path, :block

  def initialize(method, path, block)
    @method = method
    @path = path
    @block = block
  end

  def match(method, path)
    self.method == method && self.path == path
  end

  def call
    block.call
  end
end

@routes = []

def get(path, &block)
  @routes << Route.new('get', path, block)
end

def match(request)
  method, path = request.split(' ')[0,2]
  method.downcase!
  puts @routes.find { |route| route.match(method, path) }.call
end
