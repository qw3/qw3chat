require "qw3chat/version"
require "inflections.rb"

module Qw3chat

  class Qw3chat < Rails::Engine
    config.autoload_paths << File.expand_path("../app", __FILE__)
  end
  
end 