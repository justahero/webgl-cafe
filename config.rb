require 'dotenv'

TARGET = ENV['TARGET'] || environment

# Livereload
activate :livereload
config[:file_watcher_ignore] += [ /.idea\// ]

activate :directory_indexes

set :css_dir,     'stylesheets'
set :js_dir,      'javascripts'
set :images_dir,  'images'

# If you need additional libraries or styles
# just drop in libs/javascripts and insert require in all.js.coffee
sprockets.append_path  "libs/javascripts"
# sprockets.append_path  "libs/stylesheets"
# sprockets.append_path  "libs/fonts"
# sprockets.append_path  "libs/images"
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
