require './server'

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

%w[get post put delete patch].each do |method|
  define_method method do |path, &block|
    @routes << Route.new(method, path, block)
  end
end

def match(method, path)
  if route = @routes.find { |r| r.match(method, path) }
    route.call(path)
  else
    raise Http404, "no route matching #{method} #{path}"
  end
end
