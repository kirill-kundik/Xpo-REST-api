require 'rack'

min_app = lambda do |env|
  puts "ENV: #{env}"
  if env['REQUEST_METHOD'] == 'GET' && env['REQUEST_PATH'].match(/^\/hello\d*$/)
    [
      200,
      {'Content-Type' => 'text/html'},
      ['<h1>Hello, students!!</h1><b>Hello</b>']
    ]
  else
    [
     404,
     {'Content-Type' => 'application/json'},
     [%Q({"error": "Page not found"})]
    ]
  end
end

Rack::Handler.default.run min_app
