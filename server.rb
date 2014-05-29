require 'socket'

class HttpServer
  def initialize(port, &handler)
    server = TCPServer.open(port)
    puts "Listening on port #{port}"
    loop {
      client = server.accept
      http_info = client.gets
      method, path = http_info.split(' ')[0,2]
      puts method, path
      method.downcase!
      begin
        response_text = handler.call(method, path)
        client.puts('HTTP/1.1 200 OK')
        client.puts('Content-type: text/plain')
        client.puts("Content-length: #{response_text.size}")
        client.puts
        client.print(response_text)
      rescue Http404
        client.puts('HTTP/1.1 404 Not Found')
      end
      client.close
    }
  end
end

class Http404 < IOError
end
