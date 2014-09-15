TARGET = ENV['TARGET'] || environment

# Livereload
activate :livereload
activate :directory_indexes

set :css_dir,    'stylesheets'
set :js_dir,     'javascripts'
set :images_dir, 'images'

sprockets.append_path "libs/javascripts"
sprockets.append_path "vendor"

configure :development do
  set :debug_assets, true
end

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :relative_assets
end
