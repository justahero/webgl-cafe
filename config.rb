TARGET = ENV['TARGET'] || environment

# Livereload
activate :livereload
# activate :directory_indexes

set :css_dir,    'stylesheets'
set :js_dir,     'javascripts'
set :images_dir, 'images'
set :layouts_dir, 'layouts'

sprockets.append_path "libs/javascripts"
sprockets.append_path "resources"
sprockets.append_path "vendor"

# auto generate all Cafe sample files
samples = Dir['source/samples/*/'].map{ |d| File.basename(d) }
samples.each do |sample|
  STDOUT.puts "SAMPLE: #{sample}"
  proxy "examples/#{sample}/index.html", "sample.html", locals: { :sample => sample }, :ignore => true
end

configure :development do
  set :debug_assets, true
end

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :relative_assets
end
