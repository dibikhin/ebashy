require 'pp'

$stdout.sync = true

use Rack::Static,
  :urls => ["/css", "/js", "/img"],
  :root => "."

run lambda { |env|
  req_path = env["REQUEST_PATH"]
  filename = req_path == '/' ? 'index.html' : req_path[1..req_path.size]
  [
    200,
    {
      'Content-Type'  => 'text/html',
      'Cache-Control' => 'private, no-cache, max-age=0'
    },
    File.open(filename, File::RDONLY)
  ]
}