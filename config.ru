require 'pp'

$stdout.sync = true

use Rack::Static,
  :urls => ["/css", "/js", "/img"],
  :root => "."

run lambda { |env|
  filename = env["REQUEST_PATH"] == '/' ? 'index.html' : env["REQUEST_PATH"]
  [
    200,
    {
      'Content-Type'  => 'text/html',
      'Cache-Control' => 'private, no-cache, max-age=0'
    },
    File.open(filename, File::RDONLY)
  ]
}