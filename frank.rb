@names = []

class Route
    attr_accessor :path, :handler

    def initialize(path, handler)
        @path = path
        path_regex_string = '\A' + path.split('/').map do |part|
            if part.start_with?(':')
                '(.*)'
            else
                part
            end
        end.join('/') + '\z'
        @path_regex = Regexp.new(path_regex_string)
        @handler = handler
    end

    def matches?(path)
        @path_regex.match(path)
    end

    def handle(path)
        handler.call(@path_regex.match(path).captures[0])
    end
end

def get(path, &block)
    @names << Route.new(path, block)
end

def match(http_request)
    method, path, version = http_request.split(' ')
    @names.find { |route| route.matches?(path) }.handle(path)
end
