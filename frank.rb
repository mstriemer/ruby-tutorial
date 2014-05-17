class Route
  attr_accessor :method, :path, :path_matches, :path_parts, :block

  def initialize(method, path, block)
    @method = method
    @path = path
    @path_parts = path.split('/')
    @path_matches = []
    path_parts.each_with_index do |part, i|
      @path_matches << i if part.start_with?(':')
    end
    @block = block
  end

  def match(method, path)
    path_parts = path.split('/')
    self.method == method &&
        self.path_parts.size == path_parts.size &&
        path_parts.size.times { |i| self.path_parts[i].start_with?(':') ||
                                    self.path_parts[i] == path_parts[i] }
  end

  def call(path)
    if !@path_matches.empty?
      path_parts = path.split('/')
      args = @path_matches.map { |i| path_parts[i] }
    else
      args = []
    end
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
