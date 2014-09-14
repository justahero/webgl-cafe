require 'rubygems'
require 'middleman/rack'

use Rack::Rewrite do
  rewrite %r{^[^.]*(.html)?$}, '/index.html'
end

run Middleman.server
