require 'rake'
require 'bundler/setup'

namespace :build do
  def deploy(environment)
    STDOUT.puts "Building application for #{environment}"
    pid = spawn({:TARGET => environment}, "bundle exec middleman build", :err => :err, :out => :out)
    Process.wait pid
  end

  [ :production, :development ].each do |env|
    desc "Build application for environment #{env}"
    task env do
      deploy env
    end
  end
end
